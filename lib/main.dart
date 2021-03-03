import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Fingerprint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF3C3E52),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
