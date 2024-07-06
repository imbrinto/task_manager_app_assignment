import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_constants.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  bool _isRegisterUserInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _emailTEController,
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
                      style: const TextStyle(color: Colors.black),
                      controller: _firstNameTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter first name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _lastNameTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter last name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _mobileTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: _showPassword == false,
                      style: const TextStyle(color: Colors.black),
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword = !_showPassword;
                                if (mounted) setState(() {});
                              },
                              icon: _showPassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined))),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: _isRegisterUserInProgress == false,
                      replacement: const CentredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _registerUser();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
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

  Future<void> _registerUser() async {
    _isRegisterUserInProgress = true;
    if (mounted) setState(() {});

    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": ""
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);
    _isRegisterUserInProgress = false;
    if (mounted) setState(() {});

    if (response.isSuccess) {
      if (mounted) {
        _clearTextFields();
        showSnackBarMessage(context, 'Registration Success.');
      } else {
        if (mounted) {
          showSnackBarMessage(context, 'Registration failed! Try again.');
        }
      }
    }
  }

  void _clearTextFields() {
    _firstNameTEController.clear();
    _emailTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
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
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}


