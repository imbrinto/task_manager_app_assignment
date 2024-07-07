import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/update_profile_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/network_cached_image.dart';

AppBar profileAppBar(BuildContext context,[fromUpdateScreen = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        child: GestureDetector(
          onTap: () {
            if(fromUpdateScreen){
              return;
            }
            _onTapNavToUpdateProfile(context);
          },
          child: const NetworkCachedImage(
            url: '',
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if(fromUpdateScreen){
          return;
        }
        _onTapNavToUpdateProfile(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName ?? '',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
          ),
          Text(
            AuthController.userData?.email ?? '',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          await AuthController.clearAllData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      )
    ],
  );
}

void _onTapNavToUpdateProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const UpdateProfileScreen(),
    ),
  );
}
