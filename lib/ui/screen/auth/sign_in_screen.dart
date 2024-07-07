import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/login_model.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/email_verification_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_up_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/main_bottom_nav_bar.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_constants.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isSignInApiInProgress = false;

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      'Get Started with',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailTEController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter email address';
                        }
                        if (AppConstants.emailRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _showPassword == false,
                      style: const TextStyle(color: Colors.black),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) setState(() {});
                          },
                          icon: _showPassword
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                ),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Visibility(
                      visible: _isSignInApiInProgress == false,
                      replacement: const CentredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapNavToMainBottomNavBar();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    const SizedBox(height: 50),
                    buildRedirectToSignUpAndForgotPassScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNavToMainBottomNavBar() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _isSignInApiInProgress = true;
    if (mounted) setState(() {});

    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text,
      "password": _passwordTEController.text
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestInput);
    _isSignInApiInProgress = false;
    if (mounted) setState(() {});

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);


      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavBar(),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Email/Password is incorrect! Try again.",true);
      }
    }
  }

  Widget buildRedirectToSignUpAndForgotPassScreen() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = _onTapNavigateEmailVerifyPage,
                text: 'Forgot Password?',
                style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                )),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapNavigateSignUpPage,
                  text: "Sign Up",
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

  void _onTapNavigateSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _onTapNavigateEmailVerifyPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
