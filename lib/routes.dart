
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // splash: (context) => const SplashScreen(),
      // login: (context) => const LoginScreen(),
    };
  }
}