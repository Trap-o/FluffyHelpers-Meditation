import 'dart:core';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/return_to_main_icon_button.dart';
import '../../services/supabase_storage_service.dart';

const String _titleText = "Створення";

class PlaylistCreator extends StatefulWidget {
  const PlaylistCreator({super.key});

  @override
  State<PlaylistCreator> createState() => _PlaylistCreatorState();
}

class _PlaylistCreatorState extends State<PlaylistCreator> {

  void selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        SupabaseStorageService supabaseStorageService = SupabaseStorageService();

        final publicUrl = await supabaseStorageService.uploadAudioFile(
          file: file,
          fileName: basename(file.path),
        );

        print('✅ Завантажено. Public URL: $publicUrl');
      } else {
        print('⚠️ Файл не вибрано');
      }
    } catch (e) {
      print('❌ Помилка при завантаженні: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
        leading: const ReturnToMainIconButton(),
      ),
      body: Column(
        children: [
          Text(
            "Choose music:",
            style: AppTextStyles.title,
          ),
          FloatingActionButton(
            onPressed: selectFile,
            tooltip: 'Pick File',
            child: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }
}