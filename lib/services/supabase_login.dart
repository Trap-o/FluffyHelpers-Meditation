// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// Future<void> loginToSupabaseWithFirebase() async {
//   final firebaseUser = FirebaseAuth.instance.currentUser;
//   if (firebaseUser != null) {
//     final idToken = await firebaseUser.getIdToken(true);
//
//     await Supabase.instance.client.auth.signInWithIdToken(
//       provider: 'firebase', // ✅ використовуємо назву провайдера як рядок
//       idToken: idToken,
//     );
//
//     print('Успішна авторизація в Supabase');
//   } else {
//     print('Користувач не увійшов у Firebase');
//   }
// }