import 'package:flutter/material.dart';

import 'app_button_styles.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class MainAppTheme {
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
          titleLarge: AppTextStyles.title,
          titleMedium: AppTextStyles.title,
          titleSmall: AppTextStyles.title,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.body,
          bodySmall: AppTextStyles.body,
          displayLarge: AppTextStyles.body,
          displayMedium: AppTextStyles.body,
          displaySmall: AppTextStyles.body,
          headlineLarge: AppTextStyles.title,
          headlineMedium: AppTextStyles.title,
          headlineSmall: AppTextStyles.title,
          labelLarge: AppTextStyles.body,
          labelMedium: AppTextStyles.body,
          labelSmall: AppTextStyles.body),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.highlight,
        surface: AppColors.primaryBackground,
        brightness: Brightness.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.highlight)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.highlight)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.highlight)),
        labelStyle: AppTextStyles.form,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(AppColors.text))),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: AppButtonStyles.secondary));
}
