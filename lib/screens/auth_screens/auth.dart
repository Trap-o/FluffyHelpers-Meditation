import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../../constants/app_images_paths.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/private_data.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fb_auth.User?>(
      stream: fb_auth.FirebaseAuth.instance.authStateChanges(),
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
                          AppImagesPaths.plantPicture,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Почнімо медитувати вже сьогодні!",
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/', (Route<dynamic> route) => false,
          );
        });

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}