import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duo_practice/constants/app_form_styles.dart';

import '../../../../constants/app_text_styles.dart';

class CustomPasswordField extends StatelessWidget {
  final String labelText;
  final String? Function(String?) validator;
  final bool isError;
  final bool isObscured;
  final VoidCallback onVisibilityToggle;
  final TextEditingController? controller;

  const CustomPasswordField({
    super.key,
    required this.labelText,
    required this.validator,
    required this.isError,
    required this.isObscured,
    required this.onVisibilityToggle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      decoration: AppFormStyles.formInputDecorationPassword(
        labelText: labelText,
        isError: isError,
        isObscured: isObscured,
        onVisibilityToggle: onVisibilityToggle,
      ),
      validator: validator,
      style: AppTextStyles.form,
      maxLength: 20,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
    );
  }
}