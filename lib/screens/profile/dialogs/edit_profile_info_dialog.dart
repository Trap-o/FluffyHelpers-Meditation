// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../constants/app_button_styles.dart';
// import '../../../constants/app_colors.dart';
// import '../../../constants/app_text_styles.dart';
// import '../../auth_screens/forms/custom_fields/custom_text_field.dart';
// import '../../auth_screens/forms/input_validators/name_validator.dart';
//
// class ProfileEditDialog extends StatelessWidget {
//   final TextEditingController userNameController;
//   final Map<String, bool> inputStatus;
//   final Function(String) onSave;
//
//   const ProfileEditDialog({
//     super.key,
//     required this.userNameController,
//     required this.inputStatus,
//     required this.onSave,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(10),
//       alignment: Alignment.center,
//       backgroundColor: AppColors.secondaryBackground,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Змінити дані", style: AppTextStyles.title),
//             const SizedBox(height: 20),
//             CustomTextField(
//               labelText: "Введіть Ваше ім'я",
//               validator: (value) => NameValidator.validate(value, inputStatus),
//               isError: inputStatus['isWrongInputName'] ?? false,
//               controller: userNameController,
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       style: AppButtonStyles.secondary,
//                       child: const Text("Відміна"),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         checkInputName(context);
//                       },
//                       style: AppButtonStyles.primary,
//                       child: const Text("Зберегти"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkInputName(BuildContext context) async {
//     final errorMessage = NameValidator.validate(userNameController.text, inputStatus);
//     if (inputStatus['isWrongInputName'] == false) {
//       String newName = userNameController.text;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('userName', newName);
//       Navigator.of(context).pop(newName);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(errorMessage ?? '')),
//       );
//     }
//   }
// }