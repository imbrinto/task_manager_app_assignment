import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/set_password_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();

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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                      'A 6 digit verification pin will be sent to your email address',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  _buildPinCodeTextField(),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _onTapNavToSetPassScreen();
                    },
                    child: const Text('Verify'),
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

  void _onTapNavToSetPassScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetPasswordScreen(),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle(color: Colors.black),
      enableActiveFill: true,
      controller: _pinTEController,
      appContext: context,
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

  @override
  void dispose() {
    super.dispose();
    _pinTEController.dispose();
  }
}
