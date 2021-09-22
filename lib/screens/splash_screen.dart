import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/SplashScreen.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
