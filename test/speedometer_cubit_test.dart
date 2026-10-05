import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedometer/core/units/app_units_controller.dart';
import 'package:speedometer/features/speedometer/location_source.dart';
import 'package:speedometer/features/speedometer/speedometer_cubit.dart';
import 'package:speedometer/features/speedometer/speedometer_state.dart';

class _FakeLocationSource implements LocationSource {
  _FakeLocationSource({
    this.serviceEnabled = true,
    this.permission = LocationPermission.whileInUse,
    this.requestResult,
  });

  bool serviceEnabled;
  LocationPermission permission;
  LocationPermission? requestResult;
  final positions = StreamController<Position>.broadcast();

  @override
  Future<bool> isServiceEnabled() async => serviceEnabled;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async =>
      requestResult ?? permission;

  @override
  Stream<ServiceStatus> serviceStatusStream() => const Stream.empty();

  @override
  Stream<Position> positionStream() => positions.stream;

  @override
  Future<bool> openAppSettings() async => true;

  @override
  Future<bool> openLocationSettings() async => true;
}

Position _pos({
  required double lat,
  required double speed,
  required DateTime at,
  double accuracy = 5,
}) => Position(
  latitude: lat,
  longitude: 0,
  timestamp: at,
  accuracy: accuracy,
  altitude: 2800,
  altitudeAccuracy: 1,
  heading: 0,
  headingAccuracy: 1,
  speed: speed,
  speedAccuracy: 1,
);

void main() {
  group('SpeedometerCubit', () {
    test('reports disabled location service', () async {
      final cubit = SpeedometerCubit(
        _FakeLocationSource(serviceEnabled: false),
      );
      await cubit.start();
      expect(cubit.state.status, SpeedometerStatus.serviceDisabled);
      await cubit.close();
    });

    test('requests permission and reports permanent denial', () async {
      final cubit = SpeedometerCubit(
        _FakeLocationSource(
          permission: LocationPermission.denied,
          requestResult: LocationPermission.deniedForever,
        ),
      );
      await cubit.start();
      expect(cubit.state.status, SpeedometerStatus.permissionDeniedForever);
      await cubit.close();
    });

    test(
      'waits for a fix, then tracks speed, top speed and distance',
      () async {
        final source = _FakeLocationSource();
        final cubit = SpeedometerCubit(source);
        await cubit.start();
        expect(cubit.state.status, SpeedometerStatus.waitingForFix);

        final t0 = DateTime(2026, 1, 1, 12);
        source.positions.add(_pos(lat: 0, speed: 10, at: t0));
        // ~111 m north, 10 s later.
        source.positions.add(
          _pos(lat: 0.001, speed: 12, at: t0.add(const Duration(seconds: 10))),
        );
        source.positions.add(
          _pos(lat: 0.001, speed: 0.2, at: t0.add(const Duration(seconds: 11))),
        );
        await pumpEventQueue();

        final s = cubit.state;
        expect(s.status, SpeedometerStatus.tracking);
        expect(s.speedMps, 0, reason: 'GPS jitter below threshold is still');
        expect(s.topSpeedMps, 12);
        expect(s.distanceMeters, closeTo(110.6, 1));
        expect(s.averageSpeedMps, closeTo(11.06, 0.2));
        await cubit.close();
      },
    );

    test('ignores inaccurate fixes for distance', () async {
      final source = _FakeLocationSource();
      final cubit = SpeedometerCubit(source);
      await cubit.start();

      final t0 = DateTime(2026, 1, 1, 12);
      source.positions.add(_pos(lat: 0, speed: 5, at: t0));
      source.positions.add(
        _pos(
          lat: 0.01,
          speed: 5,
          accuracy: 120,
          at: t0.add(const Duration(seconds: 1)),
        ),
      );
      await pumpEventQueue();

      expect(cubit.state.distanceMeters, 0);
      await cubit.close();
    });

    test('resetTrip clears trip stats but keeps tracking', () async {
      final source = _FakeLocationSource();
      final cubit = SpeedometerCubit(source);
      await cubit.start();

      final t0 = DateTime(2026, 1, 1, 12);
      source.positions.add(_pos(lat: 0, speed: 30, at: t0));
      source.positions.add(
        _pos(lat: 0.001, speed: 8, at: t0.add(const Duration(seconds: 5))),
      );
      await pumpEventQueue();
      cubit.resetTrip();

      expect(cubit.state.status, SpeedometerStatus.tracking);
      expect(cubit.state.topSpeedMps, 8);
      expect(cubit.state.distanceMeters, 0);
      await cubit.close();
    });
  });

  group('AppUnitsPreference', () {
    test('converts speed', () {
      expect(AppUnitsPreference.metric.speedFromMps(10), closeTo(36, 1e-9));
      expect(
        AppUnitsPreference.imperial.speedFromMps(10),
        closeTo(22.369, 1e-3),
      );
    });

    test('converts distance and altitude', () {
      expect(AppUnitsPreference.metric.distanceFromMeters(1500), 1.5);
      expect(
        AppUnitsPreference.imperial.distanceFromMeters(1609.344),
        closeTo(1, 1e-9),
      );
      expect(
        AppUnitsPreference.imperial.altitudeFromMeters(100),
        closeTo(328.08, 1e-2),
      );
    });

    test('defaults to metric for unknown storage values', () {
      expect(AppUnitsPreference.fromStorage(null), AppUnitsPreference.metric);
      expect(
        AppUnitsPreference.fromStorage('imperial'),
        AppUnitsPreference.imperial,
      );
    });
  });
}
