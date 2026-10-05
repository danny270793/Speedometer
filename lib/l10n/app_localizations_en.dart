// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Speedometer';

  @override
  String get settings => 'Settings';

  @override
  String get retry => 'Try again';

  @override
  String get speedResetTrip => 'Reset trip';

  @override
  String get speedResetTripDone => 'Trip stats were reset.';

  @override
  String get statTopSpeed => 'Top speed';

  @override
  String get statAverageSpeed => 'Average';

  @override
  String get statDistance => 'Distance';

  @override
  String get statAltitude => 'Altitude';

  @override
  String get locationTitle => 'Current location';

  @override
  String locationAccuracy(String meters) {
    return 'Accuracy ±$meters m';
  }

  @override
  String get locationOpenInMaps => 'Open in Maps';

  @override
  String get waitingForGpsTitle => 'Looking for GPS signal';

  @override
  String get waitingForGpsBody =>
      'Stay under open sky for a faster, more accurate fix.';

  @override
  String get locationServiceDisabledTitle => 'Location is turned off';

  @override
  String get locationServiceDisabledBody =>
      'Turn on location services so the app can measure your speed.';

  @override
  String get openLocationSettings => 'Open location settings';

  @override
  String get permissionDeniedTitle => 'Location access needed';

  @override
  String get permissionDeniedBody =>
      'Speedometer uses your location only on this device to calculate speed, distance and altitude.';

  @override
  String get grantPermission => 'Allow location';

  @override
  String get permissionDeniedForeverTitle => 'Location access blocked';

  @override
  String get permissionDeniedForeverBody =>
      'Location permission was permanently denied. Enable it from the app settings to continue.';

  @override
  String get openAppSettings => 'Open app settings';

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
  String get settingsMeasurementSection => 'Measurement';

  @override
  String get settingsSpeedUnit => 'Units';

  @override
  String get settingsSpeedUnitMetric => 'Metric (km/h, km, m)';

  @override
  String get settingsSpeedUnitImperial => 'Imperial (mph, mi, ft)';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Spanish';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System default';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID & fingerprint';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Use biometrics to unlock the app.';

  @override
  String get settingsBiometricUnavailable =>
      'Biometric unlock is not available on this device.';

  @override
  String get settingsBiometricAuthReason =>
      'Confirm to enable biometric unlock.';

  @override
  String get settingsBiometricResumeReason => 'Authenticate to continue.';

  @override
  String get biometricLockTitle => 'App locked';

  @override
  String get biometricLockBody => 'Use Face ID or fingerprint to continue.';

  @override
  String get biometricLockUnlockButton => 'Unlock';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsAboutApp => 'About';

  @override
  String get settingsRateApp => 'Rate on Google Play';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTermsOfUse => 'Terms of use';

  @override
  String get settingsAboutTagline =>
      'Your speed, distance and altitude at a glance.';

  @override
  String get settingsAboutVersionLabel => 'Version';

  @override
  String get settingsAboutFeaturesHeading => 'What you can do';

  @override
  String get settingsAboutBulletSpeed =>
      'See your real-time speed on a clear, easy-to-read gauge.';

  @override
  String get settingsAboutBulletTrip =>
      'Track top speed, average speed and distance for each trip.';

  @override
  String get settingsAboutBulletLocation =>
      'Check your altitude and open your current location in Maps.';

  @override
  String get settingsAboutDataHeading => 'Your data';

  @override
  String get settingsAboutDataBody =>
      'Speed and location are computed from your device\'s GPS and never leave your phone. Nothing is stored after you close the app.';

  @override
  String get settingsAboutDeveloperHeading => 'Developer';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Website';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyTagline => 'Your location stays on your device.';

  @override
  String get settingsPrivacyDataTitle => 'Location data';

  @override
  String get settingsPrivacyDataBody =>
      'Speedometer reads your device\'s GPS position while the app is open to calculate speed, distance and altitude. Location is processed only on your device and is not recorded, uploaded or shared.';

  @override
  String get settingsPrivacyInfraTitle => 'What we store';

  @override
  String get settingsPrivacyInfraBody =>
      'Only your preferences (language, theme, units and biometric unlock) are saved on this device. There are no accounts and no servers.';

  @override
  String get settingsPrivacySharingTitle => 'Sharing and ads';

  @override
  String get settingsPrivacySharingBody =>
      'We do not sell your personal information, show ads or use analytics. Opening a location in Maps hands the coordinates to the maps app you choose.';

  @override
  String get settingsPrivacyNoticeTitle => 'Changes';

  @override
  String get settingsPrivacyNoticeBody =>
      'This policy may be updated from time to time. Continuing to use the app after changes are published means you accept the updated policy.';

  @override
  String get settingsTermsTagline => 'Rules for using this app.';

  @override
  String get settingsTermsAcceptanceTitle => 'Acceptance';

  @override
  String get settingsTermsAcceptanceBody =>
      'By accessing or using Speedometer, you agree to these terms. If you do not agree, do not use the app.';

  @override
  String get settingsTermsDisclaimerTitle => 'Not a certified instrument';

  @override
  String get settingsTermsDisclaimerBody =>
      'Readings depend on GPS signal quality and may be inaccurate or delayed. Always rely on your vehicle\'s speedometer and obey traffic laws. Do not interact with the app while driving.';

  @override
  String get settingsTermsLiabilityTitle => 'Limitation of liability';

  @override
  String get settingsTermsLiabilityBody =>
      'To the fullest extent permitted by law, the authors and contributors are not liable for any indirect, incidental, special, consequential or punitive damages, or any loss resulting from your use of the app or reliance on its readings.';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Your responsibilities';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'You are responsible for using the app safely and in compliance with the laws that apply to you, including laws about using phones while driving.';

  @override
  String get settingsTermsNoticeTitle => 'Changes';

  @override
  String get settingsTermsNoticeBody =>
      'These terms may be updated from time to time. If you continue to use the app after changes are posted, that indicates you accept the revised terms.';
}
