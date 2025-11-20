import 'package:animal_kart_demo2/screens/onboard_screen.dart';
import 'package:animal_kart_demo2/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:animal_kart_demo2/screens/splash_screen.dart';
import 'package:animal_kart_demo2/screens/login_screen.dart';
import 'package:animal_kart_demo2/screens/otp_screen.dart';
import 'package:animal_kart_demo2/screens/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String profileForm = '/profile-form';
  static const String home = '/home';
  static const String onBoardingScreen = '/onboarding_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case otp:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case profileForm:
        final phoneNumber = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(phoneNumberFromLogin: phoneNumber),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
