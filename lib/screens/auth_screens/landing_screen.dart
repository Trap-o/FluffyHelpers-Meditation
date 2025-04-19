import 'package:flutter/material.dart';
import 'package:flutter_duo_practice/constants/app_button_styles.dart';
import 'package:flutter_duo_practice/constants/app_colors.dart';
import 'package:flutter_duo_practice/constants/app_images_paths.dart';
import 'package:flutter_duo_practice/constants/app_spacing.dart';

import '../../constants/app_routes.dart';
import '../../constants/app_text_styles.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        title: Text("Вітаємо", style: AppTextStyles.title),
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AppImagesPaths.plantPicture,
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  'Почнімо медитувати вже сьогодні.',
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.large),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.registrationScreen);
                    },
                    style: AppButtonStyles.primary,
                    child: const Text('Зареєструватися')
                ),
                const SizedBox(height: AppSpacing.small),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                    },
                    style: AppButtonStyles.secondary,
                    child: const Text('Увійти')
                ),
                const SizedBox(height: AppSpacing.small),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                    },
                    style: AppButtonStyles.secondary,
                    child: const Text('Увійти з Google')
                )
              ],
            ),
          ),
        ),
    );
  }
}
