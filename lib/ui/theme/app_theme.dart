import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';

ThemeData lightThemeData() {

  return ThemeData.light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle:
            TextStyle(color: Colors.grey.shade400,),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,),
        titleSmall: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            fixedSize: const Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ));
}
