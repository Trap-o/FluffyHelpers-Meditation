// import 'package:flutter/material.dart';
// import 'package:flutter_duo_practice/constants/app_button_styles.dart';
// import 'package:flutter_duo_practice/constants/app_form_styles.dart';
// import 'package:flutter_duo_practice/screens/auth_screens/user_interaction/user_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../constants/app_routes.dart';
// import '../../../constants/app_spacing.dart';
// import 'custom_fields/custom_password_field.dart';
// import 'custom_fields/custom_text_field.dart';
// import 'input_validators/email_validator.dart';
// import 'input_validators/password_validator.dart';
//
// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});
//
//   @override
//   LoginFormState createState() {
//     return LoginFormState();
//   }
// }
//
// class LoginFormState extends State<LoginForm> {
//   final appFormStyles = AppFormStyles();
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, bool> _inputStatus = {
//     'isWrongInputEmail': false,
//     'isWrongInputPassword': false,
//     'isObscured': true,
//   };
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   final UserService _userStorage = UserService();
//
//   void _toggleVisibility() {
//     setState(() {
//       _inputStatus['isObscured'] = !_inputStatus['isObscured']!;
//     });
//   }
//
//   void _onLoginPressed() async {
//     if (_formKey.currentState!.validate()) {
//       String email = _emailController.text;
//       String password = _passwordController.text;
//
//       var user = await _userStorage.getUserByEmailPassword(email, password);
//
//       if (user != null) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('userEmail', user.email);
//         prefs.setString('userName', user.name);
//         prefs.setBool('isLoggedIn', true);
//         Navigator.pushReplacementNamed(context, AppRoutes.main);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Невірні дані для входу')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               CustomTextField(
//                 labelText: "Введіть Вашу пошту",
//                 validator: (value) => EmailValidator.validate(value, _inputStatus),
//                 controller: _emailController,
//                 isError: _inputStatus['isWrongInputEmail'] ?? false,
//               ),
//               const SizedBox(height: AppSpacing.medium),
//               CustomPasswordField(
//                 labelText: "Введіть Ваш пароль",
//                 validator: (value) => PasswordValidator.validate(value, _inputStatus),
//                 controller: _passwordController,
//                 isError: _inputStatus['isWrongInputPassword'] ?? false,
//                 isObscured: _inputStatus['isObscured'] ?? false,
//                 onVisibilityToggle: _toggleVisibility,
//               ),
//               const SizedBox(height: AppSpacing.medium),
//               ElevatedButton(
//                 onPressed: _onLoginPressed,
//                 style: AppButtonStyles.primary,
//                 child: const Text('Увійти'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }