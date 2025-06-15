import 'package:fluffyhelpers_meditation/constants/app_spacing.dart';
import 'package:fluffyhelpers_meditation/screens/settings/mocks/pet_options.mocks.dart';
import 'package:fluffyhelpers_meditation/services/animal_service/animal_manager.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';

const String githubDiscussionsURL =
    "https://github.com/Trap-o/FluffyHelpers-Meditation/discussions";
const String githubCodeURL =
    "https://github.com/Trap-o/FluffyHelpers-Meditation";
bool areNotificationsEnabled = true;

const Map<String, String> languages = {'en': 'English', 'uk': 'Українська'};
final languagesItems = languages.entries.map(
  (lan) => DropdownMenuItem<String>(value: lan.key, child: Text(lan.value),)
).toList();


List<DropdownMenuItem<String>> petsOptionItems(AppLocalizations loc){
  return petOptions.map((pet) {
    final label = loc.petOption(pet.key);
    return DropdownMenuItem<String>(
      value: pet.key, child: Text(label),
    );
  }).toList();
}

class Settings extends StatefulWidget {
  final Function(String) onLocaleToggle;
  final Function(String) onPetToggle;
  const Settings({super.key, required this.onLocaleToggle, required this.onPetToggle,});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? selectedLanguage;
  String? selectedPet;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
    _loadSelectedPet();
  }

  void _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language') ?? 'en';
    setState(() {
      selectedLanguage = savedLang;
    });
  }

  void _loadSelectedPet() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPet = prefs.getString('pet') ?? 'cat';
    setState(() {
      selectedPet = savedPet;
    });
  }

  Future<void> _launchURL(String pageURL) async {
    final Uri url = Uri.parse(pageURL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _sendingMails(String subject, String message) async {
    var mailId = "fluffyhelpers@gmail.com";
    await launchUrl(Uri.parse("mailto:$mailId?subject=$subject&body=$message"));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final petsItems = petsOptionItems(localizations);

    final String titleText = localizations.settingsTitle;
    final subject = localizations.supportSubject;
    final message = localizations.supportMessage;

    AnimalManager manager = AnimalManager();

    return Scaffold(
      appBar: CustomAppBar(title: titleText, leading: null,),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SettingsList(
            lightTheme: const SettingsThemeData(
              settingsListBackground: AppColors.primaryBackground,
              leadingIconsColor: AppColors.accent,
              titleTextColor: AppColors.text,
              settingsTileTextColor: AppColors.text,
              settingsSectionBackground: AppColors.secondaryBackground,
            ),
            darkTheme: const SettingsThemeData(
              settingsListBackground: AppColors.primaryBackground,
              leadingIconsColor: AppColors.accent,
              titleTextColor: AppColors.text,
              settingsTileTextColor: AppColors.text,
              settingsSectionBackground: AppColors.secondaryBackground,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            sections: [
              SettingsSection(
                title: Text(
                  localizations.settingsSectionCommon,
                  style: AppTextStyles.buttonSecondary,
                ),
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: const Icon(Icons.language),
                    title: Text(
                      localizations.languageTitle,
                      style: AppTextStyles.form,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true, // щоб меню не виходило за рамки кнопки
                        child: DropdownButton<String>(
                          value: selectedLanguage,
                          style: AppTextStyles.form,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondaryText,),
                          dropdownColor: AppColors.highlight,
                          alignment: Alignment.center,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          onChanged: (String? value) {
                            if(value != null && value != selectedLanguage){
                              widget.onLocaleToggle(value);
                              setState(() {
                                selectedLanguage = value;
                              });
                            }
                          },
                          items: languagesItems
                        ),
                      ),
                    ),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.pets_rounded),
                    title: Text(
                      localizations.petTitle,
                      style: AppTextStyles.form,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true, // щоб меню не виходило за рамки кнопки
                          child: DropdownButton<String>(
                            value: selectedPet,
                            style: AppTextStyles.form,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondaryText,),
                            dropdownColor: AppColors.highlight,
                            alignment: Alignment.center,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            onChanged: (String? value) {
                              if(value != null && value != selectedPet){
                                widget.onPetToggle(value);
                                setState(() {
                                  selectedPet = value;
                                  manager.selectedPet.value = value; // тут було AnimalManager()
                                });
                              }
                            },
                            items: petsItems
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: Text(
                  localizations.settingsSectionAbout,
                  style: AppTextStyles.buttonSecondary,
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.text),
                    leading: const Icon(Icons.folder_zip_rounded),
                    title: Text(
                      'GitHub',
                      style: AppTextStyles.setting,
                    ),
                    description: Text(
                      localizations.githubText,
                      style: AppTextStyles.smallDescription,
                    ),
                    onPressed: (context) async => _launchURL(githubCodeURL),
                  ),
                  SettingsTile.navigation(
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.text),
                    leading: const Icon(Icons.support_rounded),
                    title: Text(
                      localizations.supportTitle,
                      style: AppTextStyles.setting,
                    ),
                    description: Text(
                      localizations.supportText,
                      style: AppTextStyles.smallDescription,
                    ),
                    onPressed: (context) async => _sendingMails(subject, message),
                  ),
                  SettingsTile.navigation(
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.text),
                    leading: const Icon(Icons.feedback_rounded),
                    title: Text(
                      localizations.feedbackTitle,
                      style: AppTextStyles.setting,
                    ),
                    description: Text(
                      localizations.feedbackText,
                      style: AppTextStyles.smallDescription,
                    ),
                    onPressed: (context) async => _launchURL(githubDiscussionsURL),
                  ),
                ],
              )
            ]
          ),
        ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryBackground,
        height: AppFontSizes.title * 2.2,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
        child: Text.rich(
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.copyright_rounded,
                  color: AppColors.highlight,
                ),
              ),
              TextSpan(text: localizations.copyright),
            ],
          ),
        ),
      ),
    );
  }
}
