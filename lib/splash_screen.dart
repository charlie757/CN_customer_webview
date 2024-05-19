// ignore_for_file: prefer_const_constructors

import 'package:consumernetworks/onboarding_screen.dart';
import 'package:consumernetworks/openwebview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isIntro') != null &&
          prefs.getBool('isIntro') == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OpenWebView()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Image.asset(
          'assets/logo/logo_splash.png',
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
