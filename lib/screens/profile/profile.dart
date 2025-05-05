import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_button_styles.dart';
import 'package:flutter/material.dart';

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
            : Center(
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
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/auth');
                    },
                    label: const Text('Вийти'),
                    icon: const Icon(Icons.logout_rounded),
                  ),
                  ElevatedButton.icon(
                    style: AppButtonStyles.delete,
                    onPressed: () async {
                      await user.delete();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/auth');
                    },
                    label: const Text('Видалити акаунт'),
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ],
              ),
            ),
      ),
    );

    // return FirebaseUIActions(
    //   actions: [
    //     SignedOutAction((context){
    //       Navigator.of(context).pushReplacementNamed('/');
    //     }),
    //   ],
    //   child: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(AppSpacing.small),
    //       child: Center(
    //         child: Column(
    //           children: [
    //             CircleAvatar(
    //               radius: 100,
    //               backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
    //               child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
    //             ),
    //             const SizedBox(height: AppSpacing.small,),
    //             // Text(
    //             //   "${user?.displayName}",
    //             //   style: AppTextStyles.title,
    //             //   textAlign: TextAlign.center,
    //             // ),
    //             const EditableUserDisplayName(),
    //             const SignOutButton(),
    //             const DeleteAccountButton()
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if(snapshot.hasData){
    //       return ProfileScreen(
    //         avatarPlaceholderColor: AppColors.text,
    //         avatarSize: 200,
    //         showDeleteConfirmationDialog: true,
    //         showUnlinkConfirmationDialog: true,
    //         showMFATile: false,
    //         actions: [
    //           SignedOutAction((context){
    //             Navigator.of(context).pushReplacementNamed('/auth');
    //           })
    //         ],
    //         children: [
    //           Text("meow")
    //         ],
    //       );
    //     } else{
    //       return const Auth();
    //     }
    //   },
    // );
  }
}
