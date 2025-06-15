import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_button_styles.dart';
import 'package:fluffyhelpers_meditation/services/level_service/level_manager.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../../services/level_service/level_progress_bar.dart';
import 'dialogs/confirm_deleting_account_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LevelManager manager = LevelManager.instance;

  @override
  void initState() {
    super.initState();
    manager.startListeningToExp();
    manager.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    manager.removeListener(() {});
    manager.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final localizations = AppLocalizations.of(context)!;
    final currentExp = manager.exp;
    const int expPerLevel = 100;
    final int level = (currentExp ~/ expPerLevel) + 1;
    final int currentLevelExp = currentExp % expPerLevel;

    return SafeArea(
      child: Scaffold(
        body: user == null
            ? const Scaffold(
          body: Center(child: Text('User not logged in')),
        )
            : Stack(children: [
          Positioned(
            top: -10,
            right: 10,
            child: IconButton(
                icon: const Icon(Icons.settings_rounded),
                color: AppColors.highlight,
                iconSize: 40,
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                }),
          ),
          Center(
            child: Column(
              spacing: AppSpacing.small,
              children: [
                const SizedBox(
                  height: AppSpacing.small,
                ),
                _buildUserAvatar(user),
                const EditableUserDisplayName(),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 350,
                  ),
                  child: LevelProgressBar(
                    level: level,
                    currentExp: currentLevelExp,
                    fullExp: currentExp,
                    maxExp: expPerLevel,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  style: AppButtonStyles.primary,
                  label: Text(localizations.exitButton),
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () async {
                    await signOutUser(context);
                  },
                ),
                ElevatedButton.icon(
                  style: AppButtonStyles.delete,
                  label: Text(localizations.deleteButton),
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () {
                    showConfirmDeletingDialog(context);
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    final photoUrl = user.photoURL;
    if (photoUrl == null) {
      return const CircleAvatar(
        radius: 100,
        child: Icon(Icons.account_circle_rounded, size: 100),
      );
    }

    final highResUrl = _getHighResUserImage(photoUrl);

    return CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage(highResUrl),
    );
  }

  String _getHighResUserImage(String photoUrl) {
    // завантаження аватару з кращим розширенням
    String lowResImageSuffix = "s96-c";
    String highResImageSuffix = "s400-c";

    return photoUrl.replaceFirst(lowResImageSuffix, highResImageSuffix);
  }

  Future<void> signOutUser(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.pushReplacementNamed('/auth');
  }

  void showConfirmDeletingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ConfirmDeletingAccountDialog();
      },
    );
  }
}
