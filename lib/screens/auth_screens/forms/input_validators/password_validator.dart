// class PasswordValidator {
//   static String? validate(String? password, Map<String, bool> statusMap) {
//     if (!_checkNotNull(password)) {
//       statusMap['isWrongInputPassword'] = true;
//       return "Введіть пароль.";
//     }
//
//     if (!_checkCorrectLength(password)) {
//       statusMap['isWrongInputPassword'] = true;
//       return "Пароль має містити хоча б 8 символів.";
//     }
//
//     statusMap['isWrongInputPassword'] = false;
//     return null;
//   }
//
//   static String? compare(String? password1, String? password2, Map<String, bool> statusMap){
//     if(!_checkNotNull(password1) || !_checkCorrectLength(password1)) {
//       statusMap['isWrongInputPasswordConfirmation'] = true;
//       return "Пароль має містити хоча б 8 символів.";
//     }
//
//     if(password1?.compareTo(password2!) != 0){
//       statusMap['isWrongInputPasswordConfirmation'] = true;
//       return "Паролі не збігаються.";
//     }
//
//     statusMap['isWrongInputPasswordConfirmation'] = false;
//     return null;
//   }
//
//   static bool _checkNotNull(String? password){
//     if (password == null || password.isEmpty) {
//       return false;
//     }
//
//     return true;
//   }
//
//   static bool _checkCorrectLength(String? password){
//     if (password!.length < 8) {
//       return false;
//     }
//
//     return true;
//   }
// }