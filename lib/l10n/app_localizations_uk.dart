// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get bottomNavBarItem => '';

  @override
  String get constructorTitle => 'Конструктор';

  @override
  String get feedTitle => 'Стрічка';

  @override
  String get libraryTitle => 'Бібліотека';

  @override
  String get playlistCreatorTitle => 'Створення';

  @override
  String get playerTitle => 'Плеєр';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get welcome => 'Почнімо медитувати вже сьогодні!';

  @override
  String mainCategory(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'all': 'Все',
        'my': 'Моє',
        'relaxation': 'Релаксація',
        'focus': 'Фокус',
        'sleep': 'Сон',
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
        'nature_sounds': 'Звуки природи',
        'deep_breathing': 'Глибоке дихання',
        'calm_music': 'Спокійна музика',
        'lofi': 'Lo-Fi',
        'mindfulness': 'Уважність',
        'white_noise': 'Білий шум',
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
        'nature_sounds_desc': 'Спокійні звуки природи для глибокого розслаблення та відновлення балансу',
        'deep_breathing_desc': 'Вправи з дихання для заспокоєння розуму та зняття напруги',
        'calm_music_desc': 'Мелодії, що сприяють релаксації та створюють атмосферу гармонії',
        'lofi_desc': 'Легка Lo-Fi музика для підвищення концентрації та продуктивності',
        'mindfulness_desc': 'Звукові практики усвідомленості для зосередженості на теперішньому моменті',
        'white_noise_desc': 'Білий шум для швидкого засинання та відпочинку без перешкод',
        'asmr_desc': 'Тихі звуки та шепіт для глибокої релаксації та полегшення стресу',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get chooseImageLabel => 'Оберіть обкладинку для плейлиста:';

  @override
  String get addPhotoLabel => 'Додати фото';

  @override
  String get addAnotherPhotoLabel => 'Додати інше фото';

  @override
  String get chooseCategoryLabel => 'Категорія:';

  @override
  String get chooseDescriptionLabel => 'Опис:';

  @override
  String get hintDescriptionLabel => 'Опишіть що відображено у вашому плейлисті';

  @override
  String get compositionsSelectorLabel => 'Оберіть композиції:';

  @override
  String get yourCompositionsLabel => 'Ваші композиції:';

  @override
  String get saveButton => 'Зберегти';

  @override
  String get noImageError => 'Помилка: зображення не вибрано';

  @override
  String get noMusicError => 'Помилка: композиції не обрано';

  @override
  String get noDescriptionError => 'Помилка: опис не введено';

  @override
  String get playlistCreated => 'Плейлист створено';

  @override
  String get notEnterToAccount => 'Не увійшли в акаунт';

  @override
  String get exitButton => 'Вийти';

  @override
  String get deleteButton => 'Видалити акаунт';

  @override
  String get settingsSectionCommon => 'Загальні';

  @override
  String get settingsSectionAbout => 'Про програму';

  @override
  String get supportSubject => '[FluffyHelpers Підтримка] *Текст запитання*';

  @override
  String get supportMessage => 'Вітаю! Маю питання щодо застосунку: ';

  @override
  String get languageTitle => 'Мова';

  @override
  String get languageOption => 'Українська';

  @override
  String get petTitle => 'Тваринка';

  @override
  String petOption(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'cat': 'Кіт',
        'dog': 'Пес',
        'fox': 'Лис',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get notifications => 'Сповіщення';

  @override
  String get githubText => 'GitHub-репозиторій проєкту';

  @override
  String get supportTitle => 'Підтримка';

  @override
  String get supportText => 'Пишіть якщо виникають запитання';

  @override
  String get feedbackText => 'Пишіть якщо маєте скарги чи пропозиції';

  @override
  String get copyright => ' Розроблено Яценко Віталієм\nта Киричок Софією';

  @override
  String get okButton => 'ОК';

  @override
  String get cancelButton => 'Скасувати';

  @override
  String get confirmationText => 'Видалення акаунту призведе до видалення профілю, всіх ваших плейлистів, створеної музики тощо.\nВи впевнені?';

  @override
  String get playlistNameText => 'Введіть назву плейлиста:';

  @override
  String get noNameError => 'Помилка: назву не введено';
}
