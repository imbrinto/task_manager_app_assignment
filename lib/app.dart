import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/splash_screen.dart';
import 'package:task_manager_app_assignment/ui/theme/app_theme.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskManagerApp',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      home: const SplashScreen(),
    );
  }
}
