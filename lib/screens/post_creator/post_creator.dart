import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_font_sizes.dart';
import 'package:fluffyhelpers_meditation/screens/library/models/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/custom_exception.dart';
import '../../l10n/app_localizations.dart';
import '../library/mocks/main_category.mocks.dart';
import '../library/models/main_category.dart';

typedef DropdownEntry = DropdownMenuEntry<String>;

class PostCreator extends StatefulWidget {
  const PostCreator({super.key});

  @override
  State<PostCreator> createState() => _PostCreatorState();
}

class _PostCreatorState extends State<PostCreator> {
  SubCategory?
      _selectedPlaylist; // TODO пофіксити щоб вибір лише одного плейлиста
  List<SubCategory?> _allPlaylists = [];

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser!;

  Future<List<SubCategory>> getPlaylists() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('playlists')
        .orderBy('name', descending: true)
        .where("ownerId", isEqualTo: user.uid)
        .get();

    // print('Playlists from Firebase: ${querySnapshot.docs.length}');

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final List<String> categoryKeys = List<String>.from(data['category']);

      return SubCategory(
        id: data['id'],
        name: data['name'],
        musicList: List<String>.from(data['musicList']),
        ownerId: data['ownerId'],
        ownerName: data['ownerName'],
        categories: categoryKeys
            .map((key) => mainCategoriesMap[key])
            .where((cat) => cat != null)
            .cast<MainCategory>()
            .toList(),
        description: data['description'],
        pathToImage: data['imageUrl'],
      );
    }).toList();
  }

  Future<void> createPost(
      String title,
      String description,
      List<String> playlistIdList,
      String ownerId,
      String ownerName,
      String ownerAvatar,
      int likesNumber,
      BuildContext context,
      AppLocalizations localizations) async {
    try {
      const uuid = Uuid();
      if (playlistIdList.isEmpty && description.isEmpty) {
        throw CustomException(localizations.noContentError);
      }
      int timeNow = DateTime.now().millisecondsSinceEpoch;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeNow);
      var dateFormatter = DateFormat('dd-MM-yyyy HH:mm');

      final adData = {
        'id': uuid.v4(),
        'title': title,
        'description': description,
        'playlistList': playlistIdList,
        'ownerId': ownerId,
        'ownerName': ownerName,
        'ownerAvatar': ownerAvatar,
        'likesNumber': likesNumber,
        'createdAt': dateFormatter.format(dateTime),
      };

      await FirebaseFirestore.instance.collection('posts').add(adData);
    } catch (e) {
      rethrow;
    }
  }

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  Future<void> savePost(
      BuildContext context, AppLocalizations localizations) async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String description = descriptionController.text;
    String title = titleController.text;

    try {
      String? playlistId = _selectedPlaylist?.id;
      List<String> playlistIdList = playlistId != null ? [playlistId] : [];
      // List<String> playlistIdList =
      // _selectedPlaylist.whereType<SubCategory>().map((playlist) => playlist.id).toList();

      await createPost(title, description, playlistIdList, user.uid,
          user.displayName!, user.photoURL!, 0, context, localizations);

      titleController.clear();
      descriptionController.clear();

      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
          content: Text(localizations.postCreated, style: AppTextStyles.form),
        ),
      );

      Future.delayed(const Duration(seconds: 2));
      navigator.pushNamedAndRemoveUntil(AppRoutes.main, (route) => false);
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
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
    getPlaylists().then((playlist) {
      setState(() {
        _allPlaylists = playlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.playlistCreatorTitle;

    return Scaffold(
      appBar: CustomAppBar(
        title: titleText,
        leading: null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
        child: Wrap(children: [
          Center(
            child: Column(
              spacing: AppSpacing.small,
              children: [
                const SizedBox(height: AppSpacing.medium),
                Text(localizations.titleLabel, style: AppTextStyles.title),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: TextField(
                    maxLength: 30,
                    style: AppTextStyles.form,
                    decoration: InputDecoration(
                      hintText: localizations.hintTitleLabel,
                    ),
                    controller: titleController,
                  ),
                ),
                Text(localizations.choosePostDescriptionLabel,
                    style: AppTextStyles.title),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: TextField(
                    maxLength: 100,
                    maxLines: 5,
                    style: AppTextStyles.form,
                    decoration: InputDecoration(
                      hintText: localizations.hintPostDescriptionLabel,
                    ),
                    controller: descriptionController,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: DropdownButtonFormField<SubCategory>( // TODO якщо пусто, то треба щоб було про це повідомлення
                    value: _selectedPlaylist,
                    hint: Text(
                      localizations.playlistsSelectorLabel,
                      style: AppTextStyles.title,
                    ),
                    isExpanded: true,
                    dropdownColor: AppColors.secondaryBackground,
                    isDense: false,
                    items: _allPlaylists.map((playlist) {
                      return DropdownMenuItem<SubCategory>(
                        value: playlist,
                        child: Text(playlist!.name),
                      );
                    }).toList(),
                    onChanged: (SubCategory? newValue) {
                      setState(() {
                        _selectedPlaylist = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),

                  // MultiSelectBottomSheetField<SubCategory?>(
                  //   items: _allPlaylists
                  //       .map((e) => MultiSelectItem<SubCategory?>(e, e!.name))
                  //       .toList(),
                  //   chipDisplay: MultiSelectChipDisplay(
                  //     chipColor: AppColors.highlight,
                  //     textStyle: AppTextStyles.form,
                  //     decoration: const BoxDecoration(
                  //       color: AppColors.secondaryBackground,
                  //       borderRadius:
                  //       BorderRadius.vertical(bottom: Radius.circular(10))
                  //     ),
                  //     onTap: (value) {
                  //       _selectedPlaylist.remove(value);
                  //       return _selectedPlaylist;
                  //     },
                  //   ),
                  //   title: Text(
                  //     localizations.yourPlaylistsLabel,
                  //     style: AppTextStyles.title,
                  //   ),
                  //   buttonText: Text(
                  //     localizations.playlistsSelectorLabel,
                  //     style: AppTextStyles.buttonPrimary,
                  //   ),
                  //   initialChildSize: 0.5,
                  //   maxChildSize: 0.5,
                  //   decoration: const BoxDecoration(
                  //     color: AppColors.highlight,
                  //     borderRadius:
                  //     BorderRadius.vertical(top: Radius.circular(10))
                  //   ),
                  //   buttonIcon: const Icon(
                  //     Icons.arrow_drop_down_rounded,
                  //     color: AppColors.text,
                  //   ),
                  //   selectedColor: AppColors.accent,
                  //   backgroundColor: AppColors.secondaryBackground,
                  //   separateSelectedItems: false,
                  //   checkColor: AppColors.text,
                  //   selectedItemsTextStyle: AppTextStyles.body,
                  //   itemsTextStyle: AppTextStyles.body,
                  //   confirmText: Text(
                  //     localizations.okButton,
                  //     style: AppTextStyles.buttonPrimary,
                  //   ),
                  //   cancelText: Text(
                  //     localizations.cancelButton,
                  //     style: AppTextStyles.buttonSecondary,
                  //   ),
                  //   onConfirm: (values) {
                  //     setState(() {
                  //       _selectedPlaylist = values.whereType<SubCategory>().toList();
                  //     });
                  //   },
                  //   listType: MultiSelectListType.LIST,
                  // ),
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
                    savePost(context, localizations);
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
