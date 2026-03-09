import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workease_assistant/features/emotion/providers/emotion_provider.dart';
import 'package:workease_assistant/features/tasks/providers/task_provider.dart';
import 'routes.dart';
import 'features/auth/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EmotionProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const WorkEaseApp(),
    ),
  );
}

class WorkEaseApp extends StatelessWidget {
  const WorkEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorkEase Assistant',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        // Optional: Professional Font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
    );
  }
}
