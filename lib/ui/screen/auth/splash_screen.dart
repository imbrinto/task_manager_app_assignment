import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app_assignment/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/main_bottom_nav_bar.dart';
import 'package:task_manager_app_assignment/ui/utilities/asset_paths.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToSignInScreen();
  }

  Future<void> _moveToSignInScreen() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    bool isUserSignedIn = await AuthController.checkAuthState();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => isUserSignedIn
                ? const MainBottomNavBar()
                : const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.logoPath,
          ),
        ),
      ),
    );
  }
}
