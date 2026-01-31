import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'features/auth/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const WorkEaseApp(),
    ),
  );
}

class WorkEaseApp extends StatelessWidget {
  const WorkEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      title: 'WorkEase Assistant',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      // If not logged in, show Login. If logged in, show Home.
      initialRoute: authProvider.isLoggedIn ? AppRoutes.home : AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}
