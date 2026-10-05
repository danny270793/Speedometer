import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persisted measurement system for speed, distance and altitude.
enum AppUnitsPreference {
  metric,
  imperial;

  static AppUnitsPreference fromStorage(String? raw) {
    switch (raw) {
      case 'imperial':
        return AppUnitsPreference.imperial;
      default:
        return AppUnitsPreference.metric;
    }
  }

  String get storageValue => switch (this) {
    AppUnitsPreference.metric => 'metric',
    AppUnitsPreference.imperial => 'imperial',
  };

  /// Converts meters per second to km/h or mph.
  double speedFromMps(double mps) => switch (this) {
    AppUnitsPreference.metric => mps * 3.6,
    AppUnitsPreference.imperial => mps * 2.2369362921,
  };

  /// Converts meters to km or miles.
  double distanceFromMeters(double meters) => switch (this) {
    AppUnitsPreference.metric => meters / 1000,
    AppUnitsPreference.imperial => meters / 1609.344,
  };

  /// Converts meters to meters or feet.
  double altitudeFromMeters(double meters) => switch (this) {
    AppUnitsPreference.metric => meters,
    AppUnitsPreference.imperial => meters * 3.280839895,
  };

  /// Upper bound of the gauge scale, in the display unit.
  double get gaugeMaximum => switch (this) {
    AppUnitsPreference.metric => 200,
    AppUnitsPreference.imperial => 120,
  };
}

class AppUnitsController extends ChangeNotifier {
  AppUnitsController();

  static const _prefKey = 'app_units_preference';

  AppUnitsPreference _preference = AppUnitsPreference.metric;

  AppUnitsPreference get preference => _preference;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _preference = AppUnitsPreference.fromStorage(prefs.getString(_prefKey));
    notifyListeners();
  }

  Future<void> setPreference(AppUnitsPreference value) async {
    if (_preference == value) return;
    _preference = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, value.storageValue);
  }
}
