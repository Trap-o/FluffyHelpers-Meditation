import 'dart:collection';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_font_sizes.dart';
import 'package:fluffyhelpers_meditation/screens/playlist_creator/models/music.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/custom_exception.dart';
import '../../global_widgets/return_to_main_icon_button.dart';
import '../../l10n/app_localizations.dart';
import '../../services/supabase_storage_service.dart';
import '../library/mocks/main_category.mocks.dart';

typedef DropdownEntry = DropdownMenuEntry<String>;

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
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('music')
        .orderBy('name', descending: true)
        //.where("userId", isEqualTo: user.uid) // TODO зробити це
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Music(
          id: data['musicId'],
          name: data['name'],
          creatorName: data['creatorName'],
          creatorId: data['creatorId'],
          url: data['url']);
    }).toList();
  }

  Future<void> createPlaylist(
      String name,
      List<String> categories,
      String description,
      List<String> musicIdList,
      String ownerId,
      String ownerName,
      BuildContext context,
      AppLocalizations localizations) async {
    try {
      if (_image == null) {
        throw CustomException(localizations.noImageError);
      }
      if (musicIdList.isEmpty) {
        throw CustomException(localizations.noMusicError);
      }
      final imageUrl = await uploadImageToStorage(_image!);
      const uuid = Uuid();
      categories.add("my");

      final adData = {
        'id': uuid.v4(),
        'name': name,
        'category': categories,
        'description': description,
        'musicList': musicIdList,
        'imageUrl': imageUrl,
        'ownerId': ownerId,
        'ownerName': ownerName,
      };

      await FirebaseFirestore.instance.collection('playlists').add(adData);
    } on Exception catch (e) {
      rethrow;
    }
  }

  final TextEditingController descriptionController = TextEditingController();
  late String dropdownCategoriesValue;

  Future<void> savePlaylist(BuildContext context, AppLocalizations localizations) async {
    try {
      String name = widget.playlistName;
      String description = descriptionController.text;
      List<String> categories = [dropdownCategoriesValue];
      if (description.isEmpty) {
        throw CustomException(localizations.noDescriptionError);
      }
      List<String> musicIdList =
          _selectedMusic.whereType<Music>().map((music) => music.id).toList();

      await createPlaylist(name, categories, description, musicIdList, user.uid,
          user.displayName!, context, localizations);

      descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
          content: Text(localizations.playlistCreated, style: AppTextStyles.form),
        ),
      );

      Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route) => false);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
          content: Text("$e", style: AppTextStyles.form),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    dropdownCategoriesValue = mainCategories[2].key;
    getMusic().then((musics) {
      setState(() {
        _allMusic = musics;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = widget.playlistName;
    final List<String> hiddenCategories = [
      mainCategories.first.key,
      mainCategories[1].key
    ];
    final List<DropdownEntry> categoriesEntries =
        UnmodifiableListView<DropdownEntry>(
      mainCategories
          .where((category) => !hiddenCategories.contains(category.key))
          .map<DropdownEntry>(
            (category) => DropdownEntry(
                value: category.key,
                label: localizations.mainCategory(category.key)),
          ),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: titleText,
        leading: const ReturnToMainIconButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
        child: Wrap(children: [
          Center(
            child: Column(
              spacing: AppSpacing.small,
              children: [
                const SizedBox(height: AppSpacing.small),
                Text(
                  localizations.chooseImageLabel,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                _image == null
                    ? Container(
                        width: MediaQuery.sizeOf(context).width - 40,
                        height: 260,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.highlight),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(localizations.addPhotoLabel, style: AppTextStyles.body),
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
                        width: MediaQuery.sizeOf(context).width - 40,
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
                                  localizations.addAnotherPhotoLabel,
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
                Column(
                  spacing: AppSpacing.small,
                  children: [
                    Text(localizations.chooseCategoryLabel, style: AppTextStyles.title),
                    SizedBox(
                      child: DropdownMenu<String>(
                        expandedInsets: null,
                        textStyle: AppTextStyles.body,
                        initialSelection: mainCategories[2].key,
                        dropdownMenuEntries: categoriesEntries,
                        onSelected: (String? value) {
                          setState(() {
                            dropdownCategoriesValue = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Text(localizations.chooseDescriptionLabel, style: AppTextStyles.title),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: TextField(
                    maxLength: 100,
                    maxLines: 5,
                    style: AppTextStyles.form,
                    decoration: InputDecoration(
                      hintText: localizations.hintDescriptionLabel,
                    ),
                    controller: descriptionController,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: MultiSelectBottomSheetField<Music?>(
                    items: _allMusic
                        .map((e) => MultiSelectItem<Music?>(e, e!.name))
                        .toList(),
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: AppColors.highlight,
                      textStyle: AppTextStyles.form,
                      decoration: const BoxDecoration(
                          color: AppColors.secondaryBackground,
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(10))),
                      onTap: (value) {
                        _selectedMusic.remove(value);
                        return _selectedMusic;
                      },
                    ),
                    title: Text(
                      localizations.yourCompositionsLabel,
                      style: AppTextStyles.title,
                    ),
                    buttonText: Text(
                      localizations.compositionsSelectorLabel,
                      style: AppTextStyles.buttonPrimary,
                    ),
                    initialChildSize: 0.5,
                    maxChildSize: 0.5,
                    decoration: const BoxDecoration(
                        color: AppColors.highlight,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppColors.text,
                    ),
                    selectedColor: AppColors.accent,
                    backgroundColor: AppColors.secondaryBackground,
                    separateSelectedItems: false,
                    checkColor: AppColors.text,
                    selectedItemsTextStyle: AppTextStyles.body,
                    itemsTextStyle: AppTextStyles.body,
                    confirmText: Text(
                      localizations.okButton,
                      style: AppTextStyles.buttonPrimary,
                    ),
                    cancelText: Text(
                      localizations.cancelButton,
                      style: AppTextStyles.buttonSecondary,
                    ),
                    onConfirm: (values) {
                      setState(() {
                        _selectedMusic = values.whereType<Music>().toList();
                      });
                    },
                    listType: MultiSelectListType.LIST,
                  ),
                ),
                const SizedBox(height: AppSpacing.large),
                TextButton.icon(
                  label: Text(
                    localizations.saveButton,
                    style: AppTextStyles.title,
                  ),
                  icon: const Icon(Icons.save_rounded,
                      color: AppColors.text, size: AppFontSizes.title),
                  style: AppButtonStyles.primary,
                  onPressed: () {
                    savePlaylist(context, localizations);
                  },
                ),
                const SizedBox(height: AppSpacing.medium),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
