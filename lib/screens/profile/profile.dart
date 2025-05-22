import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_button_styles.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photoURL = user?.photoURL;

    return SafeArea(
      child: Scaffold(
        body: user == null
            ? const Center(child: Text('Не увійшли в акаунт'))
            : Stack(
              children: [
                Positioned(
                  top: -10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded),
                    color: AppColors.highlight,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/settings');
                    }
                  ),
                ),
                Center(
                  child: Column(
                    spacing: AppSpacing.small,
                    children: [
                      const SizedBox(height: AppSpacing.small,),
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                        child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
                      ),
                      const EditableUserDisplayName(),
                      ElevatedButton.icon(
                        style: AppButtonStyles.primary,
                        label: const Text('Вийти'),
                        icon: const Icon(Icons.logout_rounded),
                        onPressed: () async {
                          await signOutUser(context);
                        },
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.delete,
                        label: const Text('Видалити акаунт'),
                        icon: const Icon(Icons.delete_rounded),
                        onPressed: () async {
                          await deleteUser(user, context);
                        },
                      ),
                    ],
                  ),
                ),
              ]
            ),
      ),
    );
  }

  Future<void> signOutUser(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.pushReplacementNamed('/auth');
  }

  Future<void> deleteUser(User user, BuildContext context) async {
    final navigator = Navigator.of(context);
    await user.delete();
    await FirebaseAuth.instance.signOut();
    navigator.pushReplacementNamed('/auth');
  }
}
