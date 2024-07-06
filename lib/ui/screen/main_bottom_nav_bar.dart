import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/cancelled_task_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/completed_task_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/in_progress_task_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/new_task_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/profile_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.g_mobiledata), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Cancelled'),
        ],
      ),
    );
  }
}
