import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workease_assistant/features/auth/providers/auth_provider.dart';
import '../../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // 1. Simulate a delay for branding (2-3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    // 2. Check Auth State (Later you can check SharedPrefs or Firebase here)
    if (!mounted) return;
    final isLoggedIn = context.read<AuthProvider>().isLoggedIn;

    // 3. Navigate to appropriate screen
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo, // Use your primary theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for your App Logo
            Icon(Icons.psychology, size: 100, color: Colors.white),
            SizedBox(height: 24),
            Text(
              "WorkEase Assistant",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}