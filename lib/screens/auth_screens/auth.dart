import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:fluffyhelpers_meditation/constants/app_routes.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images_paths.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/private_data.dart';
import '../../l10n/app_localizations.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return PopScope(
            canPop: false,
            child: SignInScreen(
              resizeToAvoidBottomInset: true,
              showAuthActionSwitch: false,
              headerMaxExtent: 600,
              oauthButtonVariant: OAuthButtonVariant.icon_and_text,
              providers: [
                GoogleProvider(clientId: PrivateData.googleProviderClientId),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.1,
                        child: Image.asset(
                          AppImagesPaths.welcomePicture,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        localizations.welcome,
                        style: AppTextStyles.title,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await navigateToMain(context);
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<void> navigateToMain(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    final navigator = Navigator.of(context);
    bool isDuplicateName = await checkUniqueName(user?.uid);
    if (!isDuplicateName) {
      await addUser(user!);
    }
    navigator.pushNamedAndRemoveUntil(AppRoutes.main, (Route<dynamic> route) => false);
  }

  Future<bool> checkUniqueName(String? userId) async {
    QuerySnapshot query =
    await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
    return query.docs.isNotEmpty;
  }

  String _getHighResUserImage(String photoUrl) {
    String lowResProfileImage = "s96-c";
    String highResProfileImage = "s400-c";

    return photoUrl.replaceFirst(lowResProfileImage, highResProfileImage);
  }

  Future<void> addUser(User user) async {
    String highResAvatar = _getHighResUserImage(user.photoURL!);

    FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set(
        <String, dynamic>{
          'name': user.displayName,
          'avatar': highResAvatar,
          'email': user.email,
          'userId': user.uid,
        }
      );
  }
}