import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:login_fingerprint/fingerprint_auth.dart';
import 'package:login_fingerprint/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FingerprintAuth _auth = FingerprintAuth();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
    _getAvailableBiometrics();
  }

  void _checkBiometric() async {
    bool canCheckBiometric = await _auth.checkBiometric();

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  void _getAvailableBiometrics() async {
    List<BiometricType> availableBiometric =
        await _auth.getAvailableBiometrics();

    if (!mounted) return;

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  void _authenticate() async {
    bool authenticate = await _auth.authenticate();

    if (!mounted) return;

    if (authenticate) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
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
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: _authenticate,
                      elevation: 0,
                      color: Color(0xFF04A5ED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Text(
                          "Authenticate",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
