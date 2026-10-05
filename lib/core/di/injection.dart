import 'package:get_it/get_it.dart';

import '../locale/app_locale_controller.dart';
import '../security/app_biometric_unlock_controller.dart';
import '../theme/app_theme_controller.dart';
import '../units/app_units_controller.dart';
import '../../features/speedometer/data/datasources/location_source.dart';
import '../../features/speedometer/presentation/cubit/speedometer_cubit.dart';

final getIt = GetIt.instance;

void setupDi() {
  getIt.registerLazySingleton<AppLocaleController>(AppLocaleController.new);
  getIt.registerLazySingleton<AppThemeController>(AppThemeController.new);
  getIt.registerLazySingleton<AppUnitsController>(AppUnitsController.new);
  getIt.registerLazySingleton<AppBiometricUnlockController>(
    AppBiometricUnlockController.new,
  );

  // speedometer
  getIt.registerLazySingleton<LocationSource>(GeolocatorLocationSource.new);
  getIt.registerFactory<SpeedometerCubit>(
    () => SpeedometerCubit(getIt<LocationSource>()),
  );
}
