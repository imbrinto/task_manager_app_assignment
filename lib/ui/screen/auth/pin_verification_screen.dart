import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/set_password_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen(
      {super.key, required this.emailAddressForRecovery});

  final String emailAddressForRecovery;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  bool _getRecoveryOTPInProgress = false;

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
                  Visibility(
                    visible: _getRecoveryOTPInProgress == false,
                    replacement: const CentredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _getRecoveryOTP();
                      },
                      child: const Text('Verify'),
                    ),
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

  Future<void> _getRecoveryOTP() async {
    _getRecoveryOTPInProgress = true;
    if (mounted) setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.recoveryOTP(
            widget.emailAddressForRecovery, _pinTEController.text.trim()));
    debugPrint(response.isSuccess.toString());
    debugPrint(_pinTEController.text.toString());
    debugPrint(widget.emailAddressForRecovery.toString());
    debugPrint(Urls.recoveryOTP(
        widget.emailAddressForRecovery, _pinTEController.text.trim()));
    if (response.isSuccess && response.responseData['status'] == 'success') {
      _onTapNavToSetPassScreen();
      if (mounted) {
        showSnackBarMessage(context, 'Set your new password');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, "Wrong OTP! Try again.", true);
      }
    }
    _getRecoveryOTPInProgress = false;
    if (mounted) setState(() {});
  }

  void _onTapNavToSetPassScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPasswordScreen(
          emailForRecovery: widget.emailAddressForRecovery,
          emailRecoveryOTP: _pinTEController.text.trim(),
        ),
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
