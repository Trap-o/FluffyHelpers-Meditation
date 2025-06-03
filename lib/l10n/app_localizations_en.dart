// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bottomNavBarItem => '';

  @override
  String get constructorTitle => 'Constructor';

  @override
  String get feedTitle => 'Feed';

  @override
  String get libraryTitle => 'Library';

  @override
  String get playlistCreatorTitle => 'Creating';

  @override
  String get playerTitle => 'Player';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get welcome => 'Let\'s start meditating today!';

  @override
  String mainCategory(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'all': 'All',
        'my': 'My',
        'relaxation': 'Relaxation',
        'focus': 'Focus',
        'sleep': 'Sleep',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get notEnterToAccount => 'Not logged into account';

  @override
  String get exitButton => 'Exit';

  @override
  String get deleteButton => 'Delete account';

  @override
  String get settingsSectionCommon => 'Common';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get supportSubject => '[FluffyHelpers Support] *Topic of question*';

  @override
  String get supportMessage => 'Hello! I have question about the app: ';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageOption => 'English';

  @override
  String get petTitle => 'Pet';

  @override
  String petOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'cat': 'Cat',
        'dog': 'Dog',
        'fox': 'Fox',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get githubText => 'GitHub repository for a project';

  @override
  String get supportTitle => 'Support';

  @override
  String get supportText => 'Write us if you have any questions';

  @override
  String get feedbackText => 'Write if you have any suggestions or complaints';

  @override
  String get copyright => ' Developed by Yatsenko Vitalii\nand Kyrychok Sofiia';

  @override
  String get okButton => 'Confirm';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmationText => 'Deleting your account will delete your profile, all your playlists, music you\'ve created, and more. Are you sure?';

  @override
  String get playlistNameText => 'Enter a playlist name:';

  @override
  String get mixNameText => 'Enter a composition name:';
}
