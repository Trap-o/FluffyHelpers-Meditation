// import 'package:flutter/material.dart';
// import 'package:flutter_duo_practice/constants/app_button_styles.dart';
// import 'package:flutter_duo_practice/constants/app_colors.dart';
// import 'package:flutter_duo_practice/constants/app_spacing.dart';
// import '../../constants/app_routes.dart';
// import '../../constants/app_text_styles.dart';
// import 'forms/registration_form.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.secondaryBackground,
//         title: Text("Зареєструватися", style: AppTextStyles.title), centerTitle: true,
//       ),
//       backgroundColor: AppColors.primaryBackground,
//       body: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(height: AppSpacing.large),
//                 Text(
//                   'Введіть свої дані для реєстрації.',
//                   style: AppTextStyles.title,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppSpacing.large),
//                 const RegistrationForm(),
//                 const SizedBox(height: AppSpacing.large),
//                 Text(
//                   'Вже маєте акаунт?',
//                   style: AppTextStyles.body,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppSpacing.small),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
//                     },
//                     style: AppButtonStyles.secondary,
//                     child: const Text('Увійти')
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }