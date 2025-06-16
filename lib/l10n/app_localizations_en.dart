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
  String get mixesListTitle => 'My compositions';

  @override
  String get welcome => 'Let\'s start meditating today!';

  @override
  String get snakeBarText => 'No sounds selected';

  @override
  String get titleLabel => 'Title:';

  @override
  String get hintTitleLabel => 'Example: Look at my new playlist!';

  @override
  String get choosePostDescriptionLabel => 'Description:';

  @override
  String get hintPostDescriptionLabel => 'Add some text about your post';

  @override
  String get playlistsSelectorLabel => 'Select playlists:';

  @override
  String get yourPlaylistsLabel => 'Your playlists:';

  @override
  String get noPlaylistsLabel => 'Create your first playlist';

  @override
  String get noContentError => 'Error: add description or playlists';

  @override
  String get postCreated => 'Post created';

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
  String subCategoryName(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'nature_sounds': 'Nature sounds',
        'deep_breathing': 'Deep breathing',
        'calm_music': 'Calm music',
        'lofi': 'Lo-Fi',
        'mindfulness': 'Mindfulness',
        'white_noise': 'White noise',
        'asmr': 'ASMR',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String subCategoryDesciption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'nature_sounds_desc': 'Calm sounds of nature for deep relaxation and restoration of balance',
        'deep_breathing_desc': 'Breathing exercises to calm the mind and relieve tension',
        'calm_music_desc': 'Melodies that promote relaxation and create an atmosphere of harmony',
        'lofi_desc': 'Light Lo-Fi music to increase concentration and productivity',
        'mindfulness_desc': 'Sound mindfulness practices to focus on the present moment',
        'white_noise_desc': 'White noise for falling asleep quickly and resting without disturbances',
        'asmr_desc': 'Soft sounds and whispers for deep relaxation and stress relief',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get chooseImageLabel => 'Choose an image for playlist:';

  @override
  String get addPhotoLabel => 'Add photo';

  @override
  String get addAnotherPhotoLabel => 'Add another photo';

  @override
  String get chooseCategoryLabel => 'Category:';

  @override
  String get chooseDescriptionLabel => 'Description:';

  @override
  String get hintDescriptionLabel => 'Describe what your playlist looks like';

  @override
  String get compositionsSelectorLabel => 'Select compositions:';

  @override
  String get yourCompositionsLabel => 'Your compositions:';

  @override
  String get saveButton => 'Save';

  @override
  String get noImageError => 'Error: image not selected';

  @override
  String get noMusicError => 'Error: music not selected';

  @override
  String get noDescriptionError => 'Error: description not given';

  @override
  String get playlistCreated => 'Playlist created';

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
        'bunny': 'Bunny',
        'mouse': 'Mouse',
        'tiger': 'Tiger',
        'red_panda': 'Red panda',
        'raccoon': 'Raccoon',
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
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackText => 'Write if you have any suggestions or complaints';

  @override
  String get copyright => ' Developed by Yatsenko Vitalii\nand Kyrychok Sofiia';

  @override
  String get okButton => 'Confirm';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmationText => 'Deleting your account will delete your profile, all your playlists, music you\'ve created, and more.\nAre you sure?';

  @override
  String get playlistNameText => 'Enter a playlist name:';

  @override
  String get noNameError => 'Error: name not given';

  @override
  String get mixNameText => 'Enter a composition name:';
}
