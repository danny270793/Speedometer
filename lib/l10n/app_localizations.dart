import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Speedometer'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @speedResetTrip.
  ///
  /// In en, this message translates to:
  /// **'Reset trip'**
  String get speedResetTrip;

  /// No description provided for @speedResetTripDone.
  ///
  /// In en, this message translates to:
  /// **'Trip stats were reset.'**
  String get speedResetTripDone;

  /// No description provided for @statTopSpeed.
  ///
  /// In en, this message translates to:
  /// **'Top speed'**
  String get statTopSpeed;

  /// No description provided for @statAverageSpeed.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get statAverageSpeed;

  /// No description provided for @statDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get statDistance;

  /// No description provided for @statAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get statAltitude;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get locationTitle;

  /// No description provided for @locationAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy ±{meters} m'**
  String locationAccuracy(String meters);

  /// No description provided for @locationOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get locationOpenInMaps;

  /// No description provided for @waitingForGpsTitle.
  ///
  /// In en, this message translates to:
  /// **'Looking for GPS signal'**
  String get waitingForGpsTitle;

  /// No description provided for @waitingForGpsBody.
  ///
  /// In en, this message translates to:
  /// **'Stay under open sky for a faster, more accurate fix.'**
  String get waitingForGpsBody;

  /// No description provided for @locationServiceDisabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is turned off'**
  String get locationServiceDisabledTitle;

  /// No description provided for @locationServiceDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services so the app can measure your speed.'**
  String get locationServiceDisabledBody;

  /// No description provided for @openLocationSettings.
  ///
  /// In en, this message translates to:
  /// **'Open location settings'**
  String get openLocationSettings;

  /// No description provided for @permissionDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Location access needed'**
  String get permissionDeniedTitle;

  /// No description provided for @permissionDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Speedometer uses your location only on this device to calculate speed, distance and altitude.'**
  String get permissionDeniedBody;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get grantPermission;

  /// No description provided for @permissionDeniedForeverTitle.
  ///
  /// In en, this message translates to:
  /// **'Location access blocked'**
  String get permissionDeniedForeverTitle;

  /// No description provided for @permissionDeniedForeverBody.
  ///
  /// In en, this message translates to:
  /// **'Location permission was permanently denied. Enable it from the app settings to continue.'**
  String get permissionDeniedForeverBody;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app settings'**
  String get openAppSettings;

  /// No description provided for @unitKmh.
  ///
  /// In en, this message translates to:
  /// **'km/h'**
  String get unitKmh;

  /// No description provided for @unitMph.
  ///
  /// In en, this message translates to:
  /// **'mph'**
  String get unitMph;

  /// No description provided for @unitKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitKm;

  /// No description provided for @unitMi.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get unitMi;

  /// No description provided for @unitMeters.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMeters;

  /// No description provided for @unitFeet.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get unitFeet;

  /// No description provided for @settingsMeasurementSection.
  ///
  /// In en, this message translates to:
  /// **'Measurement'**
  String get settingsMeasurementSection;

  /// No description provided for @settingsSpeedUnit.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get settingsSpeedUnit;

  /// No description provided for @settingsSpeedUnitMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric (km/h, km, m)'**
  String get settingsSpeedUnitMetric;

  /// No description provided for @settingsSpeedUnitImperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (mph, mi, ft)'**
  String get settingsSpeedUnitImperial;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsSecuritySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecuritySection;

  /// No description provided for @settingsBiometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Face ID & fingerprint'**
  String get settingsBiometricUnlockTitle;

  /// No description provided for @settingsBiometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics to unlock the app.'**
  String get settingsBiometricUnlockSubtitle;

  /// No description provided for @settingsBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is not available on this device.'**
  String get settingsBiometricUnavailable;

  /// No description provided for @settingsBiometricAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm to enable biometric unlock.'**
  String get settingsBiometricAuthReason;

  /// No description provided for @settingsBiometricResumeReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to continue.'**
  String get settingsBiometricResumeReason;

  /// No description provided for @biometricLockTitle.
  ///
  /// In en, this message translates to:
  /// **'App locked'**
  String get biometricLockTitle;

  /// No description provided for @biometricLockBody.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID or fingerprint to continue.'**
  String get biometricLockBody;

  /// No description provided for @biometricLockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get biometricLockUnlockButton;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @settingsAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutApp;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate on Google Play'**
  String get settingsRateApp;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsAboutTagline.
  ///
  /// In en, this message translates to:
  /// **'Your speed, distance and altitude at a glance.'**
  String get settingsAboutTagline;

  /// No description provided for @settingsAboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsAboutVersionLabel;

  /// No description provided for @settingsAboutFeaturesHeading.
  ///
  /// In en, this message translates to:
  /// **'What you can do'**
  String get settingsAboutFeaturesHeading;

  /// No description provided for @settingsAboutBulletSpeed.
  ///
  /// In en, this message translates to:
  /// **'See your real-time speed on a clear, easy-to-read gauge.'**
  String get settingsAboutBulletSpeed;

  /// No description provided for @settingsAboutBulletTrip.
  ///
  /// In en, this message translates to:
  /// **'Track top speed, average speed and distance for each trip.'**
  String get settingsAboutBulletTrip;

  /// No description provided for @settingsAboutBulletLocation.
  ///
  /// In en, this message translates to:
  /// **'Check your altitude and open your current location in Maps.'**
  String get settingsAboutBulletLocation;

  /// No description provided for @settingsAboutDataHeading.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get settingsAboutDataHeading;

  /// No description provided for @settingsAboutDataBody.
  ///
  /// In en, this message translates to:
  /// **'Speed and location are computed from your device\'s GPS and never leave your phone. Nothing is stored after you close the app.'**
  String get settingsAboutDataBody;

  /// No description provided for @settingsAboutDeveloperHeading.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsAboutDeveloperHeading;

  /// No description provided for @settingsAboutDeveloperGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settingsAboutDeveloperGithub;

  /// No description provided for @settingsAboutDeveloperWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get settingsAboutDeveloperWebsite;

  /// No description provided for @settingsAboutDeveloperYoutube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get settingsAboutDeveloperYoutube;

  /// No description provided for @settingsAboutDeveloperLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get settingsAboutDeveloperLinkedin;

  /// No description provided for @settingsPrivacyTagline.
  ///
  /// In en, this message translates to:
  /// **'Your location stays on your device.'**
  String get settingsPrivacyTagline;

  /// No description provided for @settingsPrivacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Location data'**
  String get settingsPrivacyDataTitle;

  /// No description provided for @settingsPrivacyDataBody.
  ///
  /// In en, this message translates to:
  /// **'Speedometer reads your device\'s GPS position while the app is open to calculate speed, distance and altitude. Location is processed only on your device and is not recorded, uploaded or shared.'**
  String get settingsPrivacyDataBody;

  /// No description provided for @settingsPrivacyInfraTitle.
  ///
  /// In en, this message translates to:
  /// **'What we store'**
  String get settingsPrivacyInfraTitle;

  /// No description provided for @settingsPrivacyInfraBody.
  ///
  /// In en, this message translates to:
  /// **'Only your preferences (language, theme, units and biometric unlock) are saved on this device. There are no accounts and no servers.'**
  String get settingsPrivacyInfraBody;

  /// No description provided for @settingsPrivacySharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sharing and ads'**
  String get settingsPrivacySharingTitle;

  /// No description provided for @settingsPrivacySharingBody.
  ///
  /// In en, this message translates to:
  /// **'We do not sell your personal information, show ads or use analytics. Opening a location in Maps hands the coordinates to the maps app you choose.'**
  String get settingsPrivacySharingBody;

  /// No description provided for @settingsPrivacyNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get settingsPrivacyNoticeTitle;

  /// No description provided for @settingsPrivacyNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'This policy may be updated from time to time. Continuing to use the app after changes are published means you accept the updated policy.'**
  String get settingsPrivacyNoticeBody;

  /// No description provided for @settingsTermsTagline.
  ///
  /// In en, this message translates to:
  /// **'Rules for using this app.'**
  String get settingsTermsTagline;

  /// No description provided for @settingsTermsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Acceptance'**
  String get settingsTermsAcceptanceTitle;

  /// No description provided for @settingsTermsAcceptanceBody.
  ///
  /// In en, this message translates to:
  /// **'By accessing or using Speedometer, you agree to these terms. If you do not agree, do not use the app.'**
  String get settingsTermsAcceptanceBody;

  /// No description provided for @settingsTermsDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Not a certified instrument'**
  String get settingsTermsDisclaimerTitle;

  /// No description provided for @settingsTermsDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'Readings depend on GPS signal quality and may be inaccurate or delayed. Always rely on your vehicle\'s speedometer and obey traffic laws. Do not interact with the app while driving.'**
  String get settingsTermsDisclaimerBody;

  /// No description provided for @settingsTermsLiabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Limitation of liability'**
  String get settingsTermsLiabilityTitle;

  /// No description provided for @settingsTermsLiabilityBody.
  ///
  /// In en, this message translates to:
  /// **'To the fullest extent permitted by law, the authors and contributors are not liable for any indirect, incidental, special, consequential or punitive damages, or any loss resulting from your use of the app or reliance on its readings.'**
  String get settingsTermsLiabilityBody;

  /// No description provided for @settingsTermsResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your responsibilities'**
  String get settingsTermsResponsibilitiesTitle;

  /// No description provided for @settingsTermsResponsibilitiesBody.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for using the app safely and in compliance with the laws that apply to you, including laws about using phones while driving.'**
  String get settingsTermsResponsibilitiesBody;

  /// No description provided for @settingsTermsNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get settingsTermsNoticeTitle;

  /// No description provided for @settingsTermsNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'These terms may be updated from time to time. If you continue to use the app after changes are posted, that indicates you accept the revised terms.'**
  String get settingsTermsNoticeBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
