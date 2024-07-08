import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/splash_screen.dart';
import 'package:task_manager_app_assignment/ui/theme/app_theme.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      title: 'TaskManagerApp',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      home: const SplashScreen(),
    );
  }
}
