// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricAuthService {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();

//check Biometric support
  static Future<bool> canCheckBiometrics() async {
    return await _localAuthentication.canCheckBiometrics;
  }

//check devicelevel auth
  static Future<bool> deviceLevelAuth() async {
    return await _localAuthentication.isDeviceSupported();
  }

//check biometric or devicelevel
  static Future<bool> checkDeviceAuthSupport() async {
    bool isSupport = await canCheckBiometrics() || await deviceLevelAuth();
    return isSupport;
  }

//check wheter fingerprint or face id biometrics enrolled
  static Future<List<BiometricType>> checkEnrolledBiometrics() async {
    return await _localAuthentication.getAvailableBiometrics();
  }

  static Future<bool> authenticateBioMetrics() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool didAuthenticate;
    try {
      List<BiometricType> availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();
//returns list of biometrics

      if (availableBiometrics.contains(BiometricType.face)) {
      } else {}
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
      } else {}
      if (availableBiometrics.contains(BiometricType.strong)) {
      } else {}
      if (availableBiometrics.contains(BiometricType.weak)) {
      } else {}
      didAuthenticate = await _localAuthentication.authenticate(
          localizedReason: "Please authenticate to continue",
          options: const AuthenticationOptions(
              biometricOnly: false,
              stickyAuth: true,
              useErrorDialogs: true,
              sensitiveTransaction: false));
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        didAuthenticate = true; //to handle no hardware auth
      } else {
        didAuthenticate = false;
      }
      print(e);
    }
    return didAuthenticate;
  }
}
