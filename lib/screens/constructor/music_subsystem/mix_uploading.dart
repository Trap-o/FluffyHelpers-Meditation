import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../services/supabase_storage_service.dart';

class MixUploading{
  Future<String> loadMixToSupabase() async{
    final dir = await getApplicationDocumentsDirectory();
    String outputPath = '${dir.path}/output_mix.mp3';

    late final String publicUrl;

    try {
      File file = File(outputPath);
      SupabaseStorageService supabaseStorageService = SupabaseStorageService();

      const uuid = Uuid();

      publicUrl = await supabaseStorageService.uploadAudioFile(
        file: file,
        fileName: basename("${uuid.v4()}_file.path"),
      );
    } catch (e) {
      print('❌ Помилка при завантаженні: $e');
    }

    return publicUrl;
  }

  Future<void> loadMixToFirebase(String mixName, String publicUrl) async {
    var user = FirebaseAuth.instance.currentUser;
    const uuid = Uuid();
    var musicId = uuid.v4();

    FirebaseFirestore.instance
        .collection('music')
        .doc(musicId)
        .set(
        <String, dynamic>{
          'musicId' : musicId,
          'name': mixName,
          'url': publicUrl,
          'creatorId': user?.uid,
          'creatorName' : user?.displayName,
        }
    );
  }
}

