import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:login_fingerprint/custom_btn.dart';
import 'package:login_fingerprint/fingerprint_auth.dart';
import 'package:login_fingerprint/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FingerprintAuth _auth = FingerprintAuth();
  bool _canCheckBiometric = false;
  List<BiometricType> _availableBiometric = [];
  String _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
    _getAvailableBiometrics();
  }

  void _checkBiometric() async {
    bool canCheckBiometric = await _auth.checkBiometric();

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  void _getAvailableBiometrics() async {
    List<BiometricType> availableBiometric =
        await _auth.getAvailableBiometrics();

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  void _authenticate() async {
    final authenticate = await _auth.authenticate();

    if (authenticate.item1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = authenticate.item2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fingerprint.png',
                    width: 120,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Fingerprint Authentication",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  if (_canCheckBiometric &&
                      _availableBiometric.contains(BiometricType.fingerprint))
                    CustomBtn(
                      text: "Authenticate",
                      onPressed: _authenticate,
                    )
                  else
                    Text(
                      'The fingerprint biometric is not available in this device.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red[300],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
