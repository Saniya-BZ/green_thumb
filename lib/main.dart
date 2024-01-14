
import 'package:flutter/material.dart';
import 'package:green_thumb/view/splash_screen.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
        primaryColor: ColorConstants.primaryColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}


