import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @bottomNavBarItem.
  ///
  /// In uk, this message translates to:
  /// **''**
  String get bottomNavBarItem;

  /// No description provided for @constructorTitle.
  ///
  /// In uk, this message translates to:
  /// **'Конструктор'**
  String get constructorTitle;

  /// No description provided for @feedTitle.
  ///
  /// In uk, this message translates to:
  /// **'Стрічка'**
  String get feedTitle;

  /// No description provided for @libraryTitle.
  ///
  /// In uk, this message translates to:
  /// **'Бібліотека'**
  String get libraryTitle;

  /// No description provided for @playlistCreatorTitle.
  ///
  /// In uk, this message translates to:
  /// **'Створення'**
  String get playlistCreatorTitle;

  /// No description provided for @playerTitle.
  ///
  /// In uk, this message translates to:
  /// **'Плеєр'**
  String get playerTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In uk, this message translates to:
  /// **'Налаштування'**
  String get settingsTitle;

  /// No description provided for @mixesListTitle.
  ///
  /// In uk, this message translates to:
  /// **'Мої композиції'**
  String get mixesListTitle;

  /// No description provided for @welcome.
  ///
  /// In uk, this message translates to:
  /// **'Почнімо медитувати вже сьогодні!'**
  String get welcome;

  /// No description provided for @snakeBarText.
  ///
  /// In uk, this message translates to:
  /// **'Не обрано жодного звуку'**
  String get snakeBarText;

  /// No description provided for @mainCategory.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, all{Все} my{Моє} relaxation{Релаксація} focus{Фокус} sleep{Сон} other{}}'**
  String mainCategory(String key);

  /// No description provided for @subCategoryName.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, nature_sounds{Звуки природи} deep_breathing{Глибоке дихання} calm_music{Спокійна музика} lofi{Lo-Fi} mindfulness{Уважність} white_noise{Білий шум} asmr{ASMR} other{}}'**
  String subCategoryName(String key);

  /// No description provided for @subCategoryDesciption.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, nature_sounds_desc{Спокійні звуки природи для глибокого розслаблення та відновлення балансу} deep_breathing_desc{Вправи з дихання для заспокоєння розуму та зняття напруги} calm_music_desc{Мелодії, що сприяють релаксації та створюють атмосферу гармонії} lofi_desc{Легка Lo-Fi музика для підвищення концентрації та продуктивності} mindfulness_desc{Звукові практики усвідомленості для зосередженості на теперішньому моменті} white_noise_desc{Білий шум для швидкого засинання та відпочинку без перешкод} asmr_desc{Тихі звуки та шепіт для глибокої релаксації та полегшення стресу} other{}}'**
  String subCategoryDesciption(String key);

  /// No description provided for @chooseImageLabel.
  ///
  /// In uk, this message translates to:
  /// **'Оберіть обкладинку для плейлиста:'**
  String get chooseImageLabel;

  /// No description provided for @addPhotoLabel.
  ///
  /// In uk, this message translates to:
  /// **'Додати фото'**
  String get addPhotoLabel;

  /// No description provided for @addAnotherPhotoLabel.
  ///
  /// In uk, this message translates to:
  /// **'Додати інше фото'**
  String get addAnotherPhotoLabel;

  /// No description provided for @chooseCategoryLabel.
  ///
  /// In uk, this message translates to:
  /// **'Категорія:'**
  String get chooseCategoryLabel;

  /// No description provided for @chooseDescriptionLabel.
  ///
  /// In uk, this message translates to:
  /// **'Опис:'**
  String get chooseDescriptionLabel;

  /// No description provided for @hintDescriptionLabel.
  ///
  /// In uk, this message translates to:
  /// **'Опишіть що відображено у вашому плейлисті'**
  String get hintDescriptionLabel;

  /// No description provided for @compositionsSelectorLabel.
  ///
  /// In uk, this message translates to:
  /// **'Оберіть композиції:'**
  String get compositionsSelectorLabel;

  /// No description provided for @yourCompositionsLabel.
  ///
  /// In uk, this message translates to:
  /// **'Ваші композиції:'**
  String get yourCompositionsLabel;

  /// No description provided for @saveButton.
  ///
  /// In uk, this message translates to:
  /// **'Зберегти'**
  String get saveButton;

  /// No description provided for @noImageError.
  ///
  /// In uk, this message translates to:
  /// **'Помилка: зображення не вибрано'**
  String get noImageError;

  /// No description provided for @noMusicError.
  ///
  /// In uk, this message translates to:
  /// **'Помилка: композиції не обрано'**
  String get noMusicError;

  /// No description provided for @noDescriptionError.
  ///
  /// In uk, this message translates to:
  /// **'Помилка: опис не введено'**
  String get noDescriptionError;

  /// No description provided for @playlistCreated.
  ///
  /// In uk, this message translates to:
  /// **'Плейлист створено'**
  String get playlistCreated;

  /// No description provided for @notEnterToAccount.
  ///
  /// In uk, this message translates to:
  /// **'Не увійшли в акаунт'**
  String get notEnterToAccount;

  /// No description provided for @exitButton.
  ///
  /// In uk, this message translates to:
  /// **'Вийти'**
  String get exitButton;

  /// No description provided for @deleteButton.
  ///
  /// In uk, this message translates to:
  /// **'Видалити акаунт'**
  String get deleteButton;

  /// No description provided for @settingsSectionCommon.
  ///
  /// In uk, this message translates to:
  /// **'Загальні'**
  String get settingsSectionCommon;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In uk, this message translates to:
  /// **'Про програму'**
  String get settingsSectionAbout;

  /// No description provided for @supportSubject.
  ///
  /// In uk, this message translates to:
  /// **'[FluffyHelpers Підтримка] *Текст запитання*'**
  String get supportSubject;

  /// No description provided for @supportMessage.
  ///
  /// In uk, this message translates to:
  /// **'Вітаю! Маю питання щодо застосунку: '**
  String get supportMessage;

  /// No description provided for @languageTitle.
  ///
  /// In uk, this message translates to:
  /// **'Мова'**
  String get languageTitle;

  /// No description provided for @languageOption.
  ///
  /// In uk, this message translates to:
  /// **'Українська'**
  String get languageOption;

  /// No description provided for @petTitle.
  ///
  /// In uk, this message translates to:
  /// **'Тваринка'**
  String get petTitle;

  /// No description provided for @petOption.
  ///
  /// In uk, this message translates to:
  /// **'{key, select, cat{Кіт} dog{Пес} fox{Лис} other{}}'**
  String petOption(String key);

  /// No description provided for @notifications.
  ///
  /// In uk, this message translates to:
  /// **'Сповіщення'**
  String get notifications;

  /// No description provided for @githubText.
  ///
  /// In uk, this message translates to:
  /// **'GitHub-репозиторій проєкту'**
  String get githubText;

  /// No description provided for @supportTitle.
  ///
  /// In uk, this message translates to:
  /// **'Підтримка'**
  String get supportTitle;

  /// No description provided for @supportText.
  ///
  /// In uk, this message translates to:
  /// **'Пишіть якщо виникають запитання'**
  String get supportText;

  /// No description provided for @feedbackText.
  ///
  /// In uk, this message translates to:
  /// **'Пишіть якщо маєте скарги чи пропозиції'**
  String get feedbackText;

  /// No description provided for @copyright.
  ///
  /// In uk, this message translates to:
  /// **' Розроблено Яценко Віталієм\nта Киричок Софією'**
  String get copyright;

  /// No description provided for @okButton.
  ///
  /// In uk, this message translates to:
  /// **'ОК'**
  String get okButton;

  /// No description provided for @cancelButton.
  ///
  /// In uk, this message translates to:
  /// **'Скасувати'**
  String get cancelButton;

  /// No description provided for @confirmationText.
  ///
  /// In uk, this message translates to:
  /// **'Видалення акаунту призведе до видалення профілю, всіх ваших плейлистів, створеної музики тощо.\nВи впевнені?'**
  String get confirmationText;

  /// No description provided for @playlistNameText.
  ///
  /// In uk, this message translates to:
  /// **'Введіть назву плейлиста:'**
  String get playlistNameText;

  /// No description provided for @noNameError.
  ///
  /// In uk, this message translates to:
  /// **'Помилка: назву не введено'**
  String get noNameError;

  /// No description provided for @mixNameText.
  ///
  /// In uk, this message translates to:
  /// **'Введіть назву композиції:'**
  String get mixNameText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
