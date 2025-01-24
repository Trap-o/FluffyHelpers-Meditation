import 'package:flutter/material.dart';
import 'package:flutter_duo_practice/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_text_styles.dart';
import 'dialogs/app_details_dialog.dart';
import 'dialogs/edit_profile_info_dialog.dart';
import 'models/profile_buttons.dart';

const _titleText = "Profile page";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _profileName = "John Doe";
  final TextEditingController _userNameController = TextEditingController();
  final Map<String, bool> _inputStatus = {'isWrongInputName': false};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileName = prefs.getString('userName') ?? "New user";
    });
  }

  Future<void> _openEditProfileDialog(BuildContext context) async {
    _userNameController.text = _profileName;
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditDialog(
          userNameController: _userNameController,
          inputStatus: _inputStatus,
          onSave: (newName) async {
            setState(() {
              _profileName = newName;
            });
            await _saveNewUserName(newName);
          },
        );
      },
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        _profileName = result;
      });
      await _saveNewUserName(result);
    }
  }

  Future<void> _saveNewUserName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', newName);
  }

  void showAppDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const AppDetailsDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
      ),
      body: Column(
        children: [
          UserProfile(profileName: _profileName),
          Expanded(
            child: ProfileWidgetsListView(
              onEditProfile: _openEditProfileDialog,
              showAppDetailsDialog: showAppDetailsDialog,
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String profileName;

  const UserProfile({super.key, required this.profileName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: AppColors.secondaryBackground,
              backgroundBlendMode: BlendMode.softLight,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.accent, AppColors.highlight],
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              profileName,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidgetsListView extends StatelessWidget {
  final Future<void> Function(BuildContext) onEditProfile;
  final void Function(BuildContext) showAppDetailsDialog;

  const ProfileWidgetsListView({super.key, required this.onEditProfile, required this.showAppDetailsDialog});

  static Map<ProfileButtons, String> buttonsLabels = {
    ProfileButtons.profileDetails: "Редагувати профіль",
    ProfileButtons.about: "Про додаток",
  };

  void switchProfileButtons(ProfileButtons button, BuildContext context) {
    switch (button) {
      case ProfileButtons.profileDetails:
        onEditProfile(context);
        break;
      case ProfileButtons.about:
        showAppDetailsDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.secondaryBackground,
        height: 30,
        thickness: 3,

      ),
      itemCount: buttonsLabels.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final button = buttonsLabels.keys.elementAt(index);
        final label = buttonsLabels[button];

        return ListTile(
          title: Text(label!),
          titleTextStyle: AppTextStyles.buttonSecondary,
          tileColor: AppColors.highlight,
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.secondaryBackground,
          ),
          onTap: () {
            switchProfileButtons(button, context);
          },
        );
      },
    );
  }
}