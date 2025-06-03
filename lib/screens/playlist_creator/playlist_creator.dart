import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffyhelpers_meditation/screens/playlist_creator/models/music.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/return_to_main_icon_button.dart';
import '../../l10n/app_localizations.dart';
import '../../services/supabase_storage_service.dart';

class PlaylistCreator extends StatefulWidget {
  final String playlistName;

  const PlaylistCreator({super.key, required this.playlistName});

  @override
  State<PlaylistCreator> createState() => _PlaylistCreatorState();
}

class _PlaylistCreatorState extends State<PlaylistCreator> {
  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      _image = image;
    });
  }

  Future uploadImageToStorage(XFile image) async {
    SupabaseStorageService supabaseStorageService = SupabaseStorageService();
    const uuid = Uuid();
    File file = File(image.path);

    final publicUrl = await supabaseStorageService.uploadFile(
        file: file,
        fileName: basename("${uuid.v4()}_file.path"),
        bucketName: 'images');

    return publicUrl;
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  List<Music?> _selectedMusic = [];
  List<Music?> _allMusic = [];

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser!;

  Future<List<Music>> getMusic() async {
    QuerySnapshot querySnapshot =
    await firestoreInstance
        .collection('music')
        .orderBy('name', descending: true)
    //.where("userId", isEqualTo: user.uid)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Music(name: data['name'], creatorName: data['creatorName'], creatorId: data['creatorId'], url: data['url']);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    getMusic().then((musics){
      setState(() {
        _allMusic = musics;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final TextEditingController descriptionController = TextEditingController();
    final String titleText = widget.playlistName;

    return Scaffold(
      appBar: CustomAppBar(
        title: titleText,
        leading: const ReturnToMainIconButton(),
      ),
      body: SingleChildScrollView(
        child: Wrap(children: [
          Center(
            child: Column(
              spacing: AppSpacing.small,
              children: [
                const SizedBox(height: AppSpacing.small),
                Text(
                  "Choose an image for playlist:",
                  style: AppTextStyles.title,
                  softWrap: true,
                ),
                _image == null
                    ? Container(
                        width: 260,
                        height: 260,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.highlight),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add photo", style: AppTextStyles.body),
                            const SizedBox(height: AppSpacing.small),
                            FloatingActionButton(
                              onPressed: getImageFromGallery,
                              tooltip: 'Pick Image',
                              child: const Icon(Icons.add_a_photo),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 260,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.highlight,
                            width: 3,
                          ),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          children: [
                            Row(
                              spacing: AppSpacing.small,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add another photo",
                                  style: AppTextStyles.body,
                                ),
                                FloatingActionButton(
                                  onPressed: getImageFromGallery,
                                  tooltip: 'Pick Image',
                                  child: const Icon(Icons.add_a_photo),
                                ),
                              ],
                            ),
                            Image.file(File(_image!.path)),
                          ],
                        ),
                      ),
                Text("Description:", style: AppTextStyles.title),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: TextField(
                    maxLength: 100,
                    maxLines: 5,
                    style: AppTextStyles.form,
                    decoration: const InputDecoration(
                      hintText:
                      "Describe what your playlist looks like",
                    ),
                    controller: descriptionController,
                  ),
                ),
                MultiSelectBottomSheetField<Music?>(
                  items: _allMusic
                      .map((e) => MultiSelectItem<Music?>(e, e!.name))
                      .toList(),
                  title: Text("Категорії"),
                  selectedColor: Colors.blue,
                  buttonText: Text("Select compositions"),
                  onConfirm: (values) {
                    setState(() {
                      _selectedMusic = values.whereType<Music>().toList();
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay.none()
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _selectedMusic.length,
                    itemBuilder: (context, index) {
                      final music = _selectedMusic[index];
                      return ListTile(
                        title: Text(music!.name, style: AppTextStyles.body,),
                        tileColor: AppColors.highlight,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
