// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Speedometer';

  @override
  String get settings => 'Ajustes';

  @override
  String get retry => 'Reintentar';

  @override
  String get speedResetTrip => 'Reiniciar viaje';

  @override
  String get speedResetTripDone => 'Se reiniciaron las estadísticas del viaje.';

  @override
  String get statTopSpeed => 'Velocidad máxima';

  @override
  String get statAverageSpeed => 'Promedio';

  @override
  String get statDistance => 'Distancia';

  @override
  String get statAltitude => 'Altitud';

  @override
  String get locationTitle => 'Ubicación actual';

  @override
  String locationAccuracy(String meters) {
    return 'Precisión ±$meters m';
  }

  @override
  String get locationOpenInMaps => 'Abrir en Mapas';

  @override
  String get waitingForGpsTitle => 'Buscando señal GPS';

  @override
  String get waitingForGpsBody =>
      'Ubícate a cielo abierto para obtener una señal más rápida y precisa.';

  @override
  String get locationServiceDisabledTitle => 'La ubicación está desactivada';

  @override
  String get locationServiceDisabledBody =>
      'Activa los servicios de ubicación para que la app pueda medir tu velocidad.';

  @override
  String get openLocationSettings => 'Abrir ajustes de ubicación';

  @override
  String get permissionDeniedTitle => 'Se necesita acceso a la ubicación';

  @override
  String get permissionDeniedBody =>
      'Velocímetro usa tu ubicación solo en este dispositivo para calcular velocidad, distancia y altitud.';

  @override
  String get grantPermission => 'Permitir ubicación';

  @override
  String get permissionDeniedForeverTitle => 'Acceso a la ubicación bloqueado';

  @override
  String get permissionDeniedForeverBody =>
      'El permiso de ubicación fue denegado permanentemente. Actívalo desde los ajustes de la app para continuar.';

  @override
  String get openAppSettings => 'Abrir ajustes de la app';

  @override
  String get unitKmh => 'km/h';

  @override
  String get unitMph => 'mph';

  @override
  String get unitKm => 'km';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMeters => 'm';

  @override
  String get unitFeet => 'ft';

  @override
  String get settingsMeasurementSection => 'Medición';

  @override
  String get settingsSpeedUnit => 'Unidades';

  @override
  String get settingsSpeedUnitMetric => 'Métrico (km/h, km, m)';

  @override
  String get settingsSpeedUnitImperial => 'Imperial (mph, mi, ft)';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Predeterminado del sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsSecuritySection => 'Seguridad';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID y huella digital';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Usa biometría para desbloquear la app.';

  @override
  String get settingsBiometricUnavailable =>
      'El desbloqueo biométrico no está disponible en este dispositivo.';

  @override
  String get settingsBiometricAuthReason =>
      'Confirma para activar el desbloqueo biométrico.';

  @override
  String get settingsBiometricResumeReason => 'Autentícate para continuar.';

  @override
  String get biometricLockTitle => 'App bloqueada';

  @override
  String get biometricLockBody =>
      'Usa Face ID o tu huella digital para continuar.';

  @override
  String get biometricLockUnlockButton => 'Desbloquear';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get settingsAboutApp => 'Acerca de';

  @override
  String get settingsRateApp => 'Calificar en Google Play';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsAboutTagline =>
      'Tu velocidad, distancia y altitud de un vistazo.';

  @override
  String get settingsAboutVersionLabel => 'Versión';

  @override
  String get settingsAboutFeaturesHeading => 'Qué puedes hacer';

  @override
  String get settingsAboutBulletSpeed =>
      'Ve tu velocidad en tiempo real en un indicador claro y fácil de leer.';

  @override
  String get settingsAboutBulletTrip =>
      'Registra la velocidad máxima, el promedio y la distancia de cada viaje.';

  @override
  String get settingsAboutBulletLocation =>
      'Consulta tu altitud y abre tu ubicación actual en Mapas.';

  @override
  String get settingsAboutDataHeading => 'Tus datos';

  @override
  String get settingsAboutDataBody =>
      'La velocidad y la ubicación se calculan con el GPS de tu dispositivo y nunca salen de tu teléfono. No se guarda nada al cerrar la app.';

  @override
  String get settingsAboutDeveloperHeading => 'Desarrollador';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Sitio web';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyTagline =>
      'Tu ubicación se queda en tu dispositivo.';

  @override
  String get settingsPrivacyDataTitle => 'Datos de ubicación';

  @override
  String get settingsPrivacyDataBody =>
      'Velocímetro lee la posición GPS de tu dispositivo mientras la app está abierta para calcular velocidad, distancia y altitud. La ubicación se procesa solo en tu dispositivo y no se registra, sube ni comparte.';

  @override
  String get settingsPrivacyInfraTitle => 'Qué guardamos';

  @override
  String get settingsPrivacyInfraBody =>
      'Solo se guardan tus preferencias (idioma, tema, unidades y desbloqueo biométrico) en este dispositivo. No hay cuentas ni servidores.';

  @override
  String get settingsPrivacySharingTitle => 'Compartir y anuncios';

  @override
  String get settingsPrivacySharingBody =>
      'No vendemos tu información personal, no mostramos anuncios ni usamos analíticas. Al abrir una ubicación en Mapas, las coordenadas se envían a la app de mapas que elijas.';

  @override
  String get settingsPrivacyNoticeTitle => 'Cambios';

  @override
  String get settingsPrivacyNoticeBody =>
      'Esta política puede actualizarse ocasionalmente. Si sigues usando la app después de publicarse los cambios, aceptas la política actualizada.';

  @override
  String get settingsTermsTagline => 'Reglas para usar esta app.';

  @override
  String get settingsTermsAcceptanceTitle => 'Aceptación';

  @override
  String get settingsTermsAcceptanceBody =>
      'Al acceder o usar Velocímetro, aceptas estos términos. Si no estás de acuerdo, no uses la app.';

  @override
  String get settingsTermsDisclaimerTitle => 'No es un instrumento certificado';

  @override
  String get settingsTermsDisclaimerBody =>
      'Las lecturas dependen de la calidad de la señal GPS y pueden ser imprecisas o tener retraso. Confía siempre en el velocímetro de tu vehículo y respeta las leyes de tránsito. No interactúes con la app mientras conduces.';

  @override
  String get settingsTermsLiabilityTitle => 'Limitación de responsabilidad';

  @override
  String get settingsTermsLiabilityBody =>
      'En la máxima medida permitida por la ley, los autores y colaboradores no son responsables de daños indirectos, incidentales, especiales, consecuentes o punitivos, ni de pérdidas derivadas del uso de la app o de la confianza en sus lecturas.';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Tus responsabilidades';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'Eres responsable de usar la app de forma segura y conforme a las leyes que te apliquen, incluidas las leyes sobre el uso del teléfono al conducir.';

  @override
  String get settingsTermsNoticeTitle => 'Cambios';

  @override
  String get settingsTermsNoticeBody =>
      'Estos términos pueden actualizarse ocasionalmente. Si sigues usando la app después de publicarse los cambios, aceptas los términos revisados.';
}
