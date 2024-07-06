import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/email_verification_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/auth/sign_up_screen.dart';
import 'package:task_manager_app_assignment/ui/screen/main_bottom_nav_bar.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/background_widget.dart';
import 'package:task_manager_app_assignment/ui/widgets/profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      maxLines: 4,
                      validator: (String? value){
                        if(value!.trim().isEmpty){
                          return 'Enter Description';
                        }return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){

                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
