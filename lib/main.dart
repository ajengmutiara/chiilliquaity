import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cabaiku/features/splash_screen.dart';
import 'package:cabaiku/firebase_options.dart';
import 'package:cabaiku/onboarding_screens/OnboardScreen.dart';
import 'package:cabaiku/features/dashboard_screen.dart';
import 'package:cabaiku/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chili Quality',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        AppRoutes.dashboard_screen: (context) => DashboardScreen(),
      },
    );
  }
}
