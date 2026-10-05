import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

enum SpeedometerStatus {
  checking,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  waitingForFix,
  tracking,
}

/// Trip statistics are kept in SI units (m/s, meters) and converted for display.
class SpeedometerState extends Equatable {
  const SpeedometerState({
    this.status = SpeedometerStatus.checking,
    this.position,
    this.speedMps = 0,
    this.topSpeedMps = 0,
    this.distanceMeters = 0,
    this.movingSeconds = 0,
  });

  final SpeedometerStatus status;
  final Position? position;
  final double speedMps;
  final double topSpeedMps;
  final double distanceMeters;
  final double movingSeconds;

  double get averageSpeedMps =>
      movingSeconds > 0 ? distanceMeters / movingSeconds : 0;

  SpeedometerState copyWith({
    SpeedometerStatus? status,
    Position? position,
    double? speedMps,
    double? topSpeedMps,
    double? distanceMeters,
    double? movingSeconds,
  }) => SpeedometerState(
    status: status ?? this.status,
    position: position ?? this.position,
    speedMps: speedMps ?? this.speedMps,
    topSpeedMps: topSpeedMps ?? this.topSpeedMps,
    distanceMeters: distanceMeters ?? this.distanceMeters,
    movingSeconds: movingSeconds ?? this.movingSeconds,
  );

  @override
  List<Object?> get props => [
    status,
    position,
    speedMps,
    topSpeedMps,
    distanceMeters,
    movingSeconds,
  ];
}
