import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedometer/l10n/app_localizations.dart';
import 'package:speedometer/pages/settings_page.dart';
import 'package:speedometer/core/di/injection.dart';
import 'package:speedometer/widgets/speed_gauge.dart';

Widget _host(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupDi();
  });

  testWidgets('gauge renders current speed and unit', (tester) async {
    await tester.pumpWidget(
      _host(
        const Scaffold(
          body: SpeedGauge(
            speed: 87.4,
            topSpeed: 110,
            maximum: 200,
            unitLabel: 'km/h',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('87'), findsOneWidget);
    expect(find.text('km/h'), findsOneWidget);
  });

  testWidgets('settings shows units, appearance, security and about', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const SettingsPage()));
    await tester.pumpAndSettle();
    expect(find.text('Units'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Face ID & fingerprint'), findsOneWidget);
  });

  testWidgets('settings is translated to Spanish', (tester) async {
    await tester.pumpWidget(
      _host(const SettingsPage(), locale: const Locale('es')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ajustes'), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
  });
}
