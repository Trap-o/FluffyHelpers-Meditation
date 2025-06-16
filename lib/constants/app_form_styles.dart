import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';

class AppFormStyles {
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(12.0));

  static const OutlineInputBorder _base = OutlineInputBorder(
    borderRadius: _borderRadius,
  );

  static InputDecoration formInputDecorationDefault({
    required String labelText,
    required bool isError,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
          color: isError ? AppColors.error : AppColors.highlight,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.fontFamily),
      errorMaxLines: 2,
      border: _defaultBorder,
      enabledBorder: _defaultBorder,
      focusedBorder: _focusedBorder,
      errorBorder: _errorBorder,
      hintStyle: AppTextStyles.buttonSecondary,
      errorStyle: AppTextStyles.error,
      counterText: '',
    );
  }

  static InputDecoration formInputDecorationPassword({
    required String labelText,
    required bool isError,
    required bool isObscured,
    VoidCallback? onVisibilityToggle,
  }) {
    final baseDecoration = formInputDecorationDefault(
      labelText: labelText,
      isError: isError,
    );

    return baseDecoration.copyWith(
      suffixIcon: IconButton(
        icon: Icon(
          isObscured ? Icons.visibility_off : Icons.visibility,
          color: isError ? AppColors.error : AppColors.highlight,
        ),
        onPressed: onVisibilityToggle,
      ),
    );
  }

  static final OutlineInputBorder _defaultBorder = _base.copyWith(
    borderSide: const BorderSide(
      color: AppColors.highlight,
      width: 1.0,
    ),
  );

  static final OutlineInputBorder _focusedBorder = _base.copyWith(
    borderSide: const BorderSide(
      color: AppColors.highlight,
      width: 3.0,
    ),
  );

  static final OutlineInputBorder _errorBorder = _base.copyWith(
    borderSide: const BorderSide(
      color: AppColors.error,
      width: 2.0,
    ),
  );
}
