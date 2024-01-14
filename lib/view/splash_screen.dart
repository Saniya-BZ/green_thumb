import 'dart:async';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      ),
    );
    // Timer(
    //   const Duration(seconds: 6),
    //       () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          ImageConstants.logo,
          width: 200,
          height: 200,
        ),
        const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: ColorConstants.primaryColor,
            ))
      ])),
    );
  }
}
