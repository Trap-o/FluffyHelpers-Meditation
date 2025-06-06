import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

const String _titleText = "Налаштування";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

bool areNotificationsEnabled = true;

class _SettingsState extends State<Settings> {

  _launchURL(String pageURL) async {
    final Uri _url = Uri.parse(pageURL);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url'); //TODO забити чи поміняти на щось нормальне
    }
  }

  _sendingMails() async {
    var mailId="fluffyhelpers@gmail.com";
    var subject="[FluffyHelpers Підтримка] *Текст запитання*";
    var message="Вітаю! Маю питання щодо застосунку: ";
    await launchUrl(Uri.parse("mailto:$mailId?subject=$subject&body=$message"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        centerTitle: true,
      ),
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
              sections: [
                SettingsSection(
                  title: Text(
                    'Загальні',
                    style: AppTextStyles.buttonSecondary,
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: const Icon(Icons.language),
                      title: Text(
                        'Мова',
                        style: AppTextStyles.setting,
                      ),
                      trailing: Text(
                        'Українська',
                        style: AppTextStyles.setting,
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(Icons.pets_rounded),
                      title: Text(
                        'Тваринка',
                        style: AppTextStyles.setting,
                      ),
                      trailing:
                      Text(
                        'Котик',
                        style: AppTextStyles.setting,
                      ),
                    ),
                    SettingsTile.switchTile(
                      leading: const Icon(Icons.notifications_rounded),
                      title: Text(
                        'Сповіщення',
                        style: AppTextStyles.setting,
                      ),
                      activeSwitchColor: AppColors.accent,
                      initialValue: areNotificationsEnabled,
                      onToggle: (bool isEnabled) {
                        setState(() {
                          areNotificationsEnabled = isEnabled;
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'Про програму',
                    style: AppTextStyles.buttonSecondary,
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile(
                      leading: const Icon(Icons.folder_zip_rounded),
                      title: Text(
                        'GitHub',
                        style: AppTextStyles.setting,
                      ),
                      description: Text(
                        "GitHub-репозиторій проєкту",
                        style: AppTextStyles.smallDescription,
                      ),
                      onPressed: (context) async => _launchURL("https://github.com/Trap-o/FluffyHelpers-Meditation"),
                    ),
                    SettingsTile(
                      leading: const Icon(Icons.support_rounded),
                      title: Text(
                        'Підтримка',
                        style: AppTextStyles.setting,
                      ),
                      description: Text(
                        "Пишіть якщо виникають запитання",
                        style: AppTextStyles.smallDescription,
                      ),
                      onPressed: (context) async => _sendingMails(),
                    ),
                    SettingsTile(
                      leading: const Icon(Icons.feedback_rounded),
                      title: Text(
                        'Feedback',
                        style: AppTextStyles.setting,
                      ),
                      description: Text(
                        "Пишіть якщо маєте скарги чи пропозиції",
                        style: AppTextStyles.smallDescription,
                      ),
                      onPressed: (context) async => _launchURL("https://github.com/Trap-o/FluffyHelpers-Meditation/discussions"),
                    ),
                  ],
                )
              ]
          ),
          Positioned(
            bottom: 20,
            child: LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              child: Text.rich(
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.fade,
                const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.copyright_rounded,
                        color: AppColors.highlight,
                      )
                    ),
                    TextSpan(text: " Розроблено Яценко Віталієм та Киричок Софією"),
                  ]
                ),
              ),
            )
          ),
        ]
      )
    );
  }
}