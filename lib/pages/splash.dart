import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedometer/pages/home.dart';
import 'package:speedometer/pages/settings.dart';

class SplashPage extends StatefulWidget {
  static String path = '/';

  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  Future<void> checkIfIsLogged() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool useFingerprint = sharedPreferences.getBool(SettingsPage.useFingerprintKey) ?? false;
    final canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    final isDeviceSupported = await localAuthentication.isDeviceSupported();
    if(canCheckBiometrics && isDeviceSupported && useFingerprint) {
      while(await localAuthentication.authenticate(
          localizedReason: 'Please authenticate to continue'
      ) == false) {}
      if (mounted) {
        Navigator.popAndPushNamed(context, HomePage.path);
      }
    } else {
      if (mounted) {
        Navigator.popAndPushNamed(context, HomePage.path);
      }
    }
  }

  @override
  void initState() {
    checkIfIsLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}