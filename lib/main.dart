import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:speedometer/pages/about.dart';
import 'package:speedometer/pages/home.dart';
import 'package:speedometer/pages/settings.dart';
import 'package:speedometer/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) =>
            MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              initialRoute: SplashPage.path,
              routes: {
                HomePage.path: (BuildContext context) => const HomePage(),
                SplashPage.path: (BuildContext context) => const SplashPage(),
                SettingsPage.path: (
                    BuildContext context) => const SettingsPage(),
                AboutPage.path: (BuildContext context) => const AboutPage(),
              },
            )
    );
  }
}
