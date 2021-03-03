import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuth {
  LocalAuthentication auth = LocalAuthentication();

  // Check the sensors whether we can use them or not
  Future<bool> checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      return canCheckBiometric;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  // Get all the available biometrics inside our device
  Future<List<BiometricType>> getAvailableBiometrics() async {
    List<BiometricType> availableBiometric;
    try {
      availableBiometric = await auth.getAvailableBiometrics();
      return availableBiometric;
    } on PlatformException catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your finger print to authenticate",
          useErrorDialogs: true,
          stickyAuth: false);
      return authenticated;
    } on PlatformException catch (e) {
      print(e);
      return authenticated;
    }
  }
}
