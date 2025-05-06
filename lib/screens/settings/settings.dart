import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        centerTitle: true,
      ),
      body: SettingsList(
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
                leading: const Icon(Icons.contrast_rounded),
                title: Text(
                  'Тема',
                  style: AppTextStyles.setting,
                ),
                trailing: Text(
                  'Темна',
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
              ),
            ],
          )
        ]
      )
    );
  }
}