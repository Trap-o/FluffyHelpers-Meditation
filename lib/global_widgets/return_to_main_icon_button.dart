import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class ReturnToMainIconButton extends StatelessWidget{

  const ReturnToMainIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: AppColors.accent,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route) => false);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}