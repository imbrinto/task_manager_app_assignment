import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';

class CentredProgressIndicator extends StatelessWidget {
  const CentredProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.themeColor,
      ),
    );
  }
}