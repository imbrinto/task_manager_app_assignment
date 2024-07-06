import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/pin_verification_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                      'Maximum length of password should not be less then 8 character with letter an number combination',
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _onTapNavToPinVerifyScreen();
                    },
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(height: 50),
                  buildMoveToSignIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNavToPinVerifyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PinVerificationScreen(),
      ),
    );
  }

  Widget buildMoveToSignIn() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Have account? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapNavigateToSignIn,
                  text: "Sign In",
                  style: const TextStyle(
                      color: AppColors.themeColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onTapNavigateToSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }
}
