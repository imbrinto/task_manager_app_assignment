import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen(
      {super.key,
      required this.emailForRecovery,
      required this.emailRecoveryOTP});

  final String emailForRecovery;
  final String emailRecoveryOTP;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _setNewPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
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
                      style: const TextStyle(color: Colors.black),
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter new password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _confirmPasswordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Confirm new password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: _setNewPasswordInProgress == false,
                      replacement: const CentredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordTEController.text.trim() ==
                                _confirmPasswordTEController.text.trim()) {
                              _setNewPassword();
                            } else {
                              showSnackBarMessage(
                                  context, "Password didn't matched.", true);
                            }
                          }
                        },
                        child: const Text('Confirm'),
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
      ),
    );
  }

  Future<void> _setNewPassword() async {
    _setNewPasswordInProgress = true;
    if (mounted) setState(() {});

    Map<String, dynamic> requestData = {
      "email": widget.emailForRecovery,
      "OTP": widget.emailRecoveryOTP,
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.recoverPassword,
      body: requestData,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      _onTapNavToPinVerifyScreen();
      if (mounted) {
        showSnackBarMessage(context, 'New Password Set.');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Failed to set new password! Try again.');
      }
    }
    _setNewPasswordInProgress = false;
    if (mounted) setState(() {});
  }

  void _onTapNavToPinVerifyScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
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
  @override
  void dispose() {
    super.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
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
