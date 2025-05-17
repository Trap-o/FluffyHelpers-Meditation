import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String> uploadAudioFile({
    required File file,
    required String fileName,
  }) async {
    final bucket = Supabase.instance.client.storage.from('musics');
    final String path = fileName; // без userId

    try {
      await bucket.upload(path, file);
      return bucket.getPublicUrl(path); // Працює без авторизації
    } catch (e) {
      throw Exception('Помилка при завантаженні: $e');
    }
  }
}