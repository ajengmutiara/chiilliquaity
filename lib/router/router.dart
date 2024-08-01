import 'package:flutter/material.dart';
import 'package:cabaiku/onboarding_screens/OnboardScreen.dart';
import 'package:cabaiku/features/splash_screen.dart';
import 'package:cabaiku/features/dashboard_screen.dart';

// Daftar rute
final Map<String, WidgetBuilder> routes = {
  AppRoutes.splash: (context) => const SplashScreen(),
  AppRoutes.onboarding_screens: (context) => const OnboardingScreen(),
  AppRoutes.dashboard_screen: (context) => const DashboardScreen(),
  // Tambahkan rute lainnya di sini
};

class AppRoutes {
  static const String splash = "/splash_screen";
  static const String onboarding_screens= "/OnboardingScreen";
  static const String dashboard_screen = "/DashboardScreen";
}
  // Tambahkan rute lainnya di sini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: AppRoutes.splash,
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AppRoutes.onboarding_screens:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case AppRoutes.dashboard_screen:
            return MaterialPageRoute(builder: (_) => const DashboardScreen());
          // Tambahkan rute lainnya di sini
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}
