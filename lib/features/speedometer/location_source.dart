import 'package:geolocator/geolocator.dart';

/// Thin seam over [Geolocator] so the cubit can be tested without a device.
abstract class LocationSource {
  Future<bool> isServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Stream<ServiceStatus> serviceStatusStream();
  Stream<Position> positionStream();
  Future<bool> openLocationSettings();
  Future<bool> openAppSettings();
}

class GeolocatorLocationSource implements LocationSource {
  @override
  Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  @override
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  @override
  Stream<ServiceStatus> serviceStatusStream() =>
      Geolocator.getServiceStatusStream();

  @override
  Stream<Position> positionStream() => Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    ),
  );

  @override
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  @override
  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
