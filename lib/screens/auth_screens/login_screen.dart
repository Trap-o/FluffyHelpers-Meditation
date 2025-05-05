// import 'package:flutter/material.dart';
// import 'package:flutter_duo_practice/constants/app_button_styles.dart';
// import 'package:flutter_duo_practice/constants/app_colors.dart';
// import 'package:flutter_duo_practice/constants/app_spacing.dart';
// import '../../constants/app_routes.dart';
// import '../../constants/app_text_styles.dart';
// import 'forms/login_form.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.secondaryBackground,
//         title: Text("Увійти", style: AppTextStyles.title), centerTitle: true,
//       ),
//       backgroundColor: AppColors.primaryBackground,
//       body: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(height: AppSpacing.large),
//                 Text(
//                   'Увійти в акаунт.',
//                   style: AppTextStyles.title,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppSpacing.large),
//                 const LoginForm(),
//                 const SizedBox(height: AppSpacing.large),
//                 Text(
//                   'Ще не маєте акаунту?',
//                   style: AppTextStyles.body,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppSpacing.small),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, AppRoutes.registrationScreen);
//                     },
//                     style: AppButtonStyles.secondary,
//                     child: const Text('Зареєструватися')
//                 ),
//               ],
//                     ),
//           ),
//       ),
//     );
//   }
// }