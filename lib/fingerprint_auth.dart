import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tuple/tuple.dart';

class FingerprintAuth {
  LocalAuthentication auth = LocalAuthentication();

  // Check the sensors whether we can use them or not
  Future<bool> checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      return canCheckBiometric;
    } on PlatformException catch (e) {
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
      return [];
    }
  }

  // Authenticate with biometrics
  Future<Tuple2<bool, String>> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger print to authenticate",
        useErrorDialogs: true,
        stickyAuth: false,
        biometricOnly: true,
      );
      return Tuple2(authenticated, null);
    } on PlatformException catch (e) {
      return Tuple2(authenticated, e.message);
    }
  }
}
