import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/user_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.userData!;
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _mobileTEController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    _buildPhotoPickerWidget(),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: const InputDecoration(hintText: 'Email'),
                      enabled: false,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(hintText: 'First Name'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.phone,
                      controller: _mobileTEController,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _passwordTEController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _updateProfileInProgress == false,
                      replacement: const CentredProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    String encodedImage = AuthController.userData?.photo ?? '';
    if (mounted) setState(() {});

    Map<String, dynamic> requestData = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text,
      "lastName": _lastNameTEController.text,
      "mobile": _mobileTEController,
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestData['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodedImage = base64Encode(file.readAsBytesSync());
      requestData['photo'] = encodedImage;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: requestData);
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
        email: _emailTEController.text,
        firstName: _firstNameTEController.text,
        lastName: _lastNameTEController.text,
        mobile: _mobileTEController.text,
        photo: encodedImage,
      );
      await AuthController.saveUserData(userModel);
      if(mounted){
        showSnackBarMessage(context, 'Profile Updated');
      }
    } else {
      if(mounted){
        showSnackBarMessage(context,
            response.errorMessage ?? 'Profile update failed! Try again.',true);
      }
    }
    _updateProfileInProgress = false;
    if (mounted) setState(() {});
  }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _pickProfilePhoto,
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              _selectedImage?.name ?? 'No image found',
              maxLines: 1,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis, color: Colors.black),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _pickProfilePhoto() async {
    final imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      _selectedImage = result;
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    super.dispose();
  }
}
