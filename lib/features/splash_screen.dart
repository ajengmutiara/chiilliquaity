import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cabaiku/features/dashboard_screen.dart';
import 'package:cabaiku/onboarding_screens/OnboardScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _precacheImages();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnboardingScreen();
      }));
    });
  }

  Future<void> _precacheImages() async {
    // Preload all the images used in the screen
    await Future.wait([
      precacheImage(Image.asset("assets/splash.png").image, context),
      precacheImage(Image.asset("assets/chilku.png").image, context),
      precacheImage(Image.asset("assets/chilku.png").image, context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/splash.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/chilku.png",
                    width: MediaQuery.of(context).size.width * 0.8,
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
