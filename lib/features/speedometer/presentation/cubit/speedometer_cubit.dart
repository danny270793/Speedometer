import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/datasources/location_source.dart';
import 'speedometer_state.dart';

class SpeedometerCubit extends Cubit<SpeedometerState> {
  SpeedometerCubit(this._source) : super(const SpeedometerState());

  final LocationSource _source;
  StreamSubscription<Position>? _positionSub;
  StreamSubscription<ServiceStatus>? _serviceSub;

  /// Below this, GPS jitter is treated as standing still (≈1.8 km/h).
  static const double stationaryThresholdMps = 0.5;

  /// Fixes worse than this are ignored for distance so drift does not add up.
  static const double maxAccuracyForDistanceMeters = 30;

  Future<void> start() async {
    _serviceSub ??= _source.serviceStatusStream().listen(
      (status) {
        if (status == ServiceStatus.enabled) {
          unawaited(start());
        } else {
          _stopTracking();
          emit(state.copyWith(status: SpeedometerStatus.serviceDisabled));
        }
      },
      // Some platforms (e.g. web) do not support service status updates.
      onError: (_) {},
    );

    if (!await _source.isServiceEnabled()) {
      emit(state.copyWith(status: SpeedometerStatus.serviceDisabled));
      return;
    }

    var permission = await _source.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _source.requestPermission();
    }
    if (isClosed) return;

    switch (permission) {
      case LocationPermission.denied:
        emit(state.copyWith(status: SpeedometerStatus.permissionDenied));
      case LocationPermission.deniedForever:
        emit(state.copyWith(status: SpeedometerStatus.permissionDeniedForever));
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        _startTracking();
    }
  }

  void _startTracking() {
    if (_positionSub != null) return;
    if (state.status != SpeedometerStatus.tracking) {
      emit(state.copyWith(status: SpeedometerStatus.waitingForFix));
    }
    _positionSub = _source.positionStream().listen(
      _onPosition,
      onError: (_) {
        _stopTracking();
        unawaited(start());
      },
    );
  }

  void _stopTracking() {
    unawaited(_positionSub?.cancel());
    _positionSub = null;
  }

  void _onPosition(Position next) {
    final speed = next.speed.isFinite && next.speed > stationaryThresholdMps
        ? next.speed
        : 0.0;

    var distance = state.distanceMeters;
    var moving = state.movingSeconds;
    final previous = state.position;
    if (previous != null &&
        speed > 0 &&
        next.accuracy <= maxAccuracyForDistanceMeters) {
      distance += Geolocator.distanceBetween(
        previous.latitude,
        previous.longitude,
        next.latitude,
        next.longitude,
      );
      final elapsed =
          next.timestamp.difference(previous.timestamp).inMilliseconds / 1000;
      if (elapsed > 0) moving += elapsed;
    }

    emit(
      state.copyWith(
        status: SpeedometerStatus.tracking,
        position: next,
        speedMps: speed,
        topSpeedMps: speed > state.topSpeedMps ? speed : state.topSpeedMps,
        distanceMeters: distance,
        movingSeconds: moving,
      ),
    );
  }

  void resetTrip() {
    emit(
      SpeedometerState(
        status: state.status,
        position: state.position,
        speedMps: state.speedMps,
        topSpeedMps: state.speedMps,
      ),
    );
  }

  Future<void> openLocationSettings() => _source.openLocationSettings();

  Future<void> openAppSettings() => _source.openAppSettings();

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _serviceSub?.cancel();
    return super.close();
  }
}
