import 'package:flutter/material.dart';

import '../../../../constants/app_form_styles.dart';
import '../../../../constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? Function(String?) validator;
  final bool isError;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.validator,
    required this.isError,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppFormStyles.formInputDecorationDefault(
        labelText: labelText,
        isError: isError,
      ),
      validator: validator,
      style: AppTextStyles.form,
      keyboardType: keyboardType,
      maxLength: 50,
    );
  }
}