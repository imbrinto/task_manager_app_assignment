import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/pin_verification_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                      'A 6 digit verification pin will be sent to your email address',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _onTapNavToPinVerifyScreen();
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined),
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
