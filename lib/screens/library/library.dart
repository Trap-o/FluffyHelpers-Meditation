import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffyhelpers_meditation/screens/library/widgets/main_category_chips.dart';
import 'package:fluffyhelpers_meditation/screens/library/widgets/sub_category_grid_view.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'dialogs/new_playlist_dialog.dart';
import 'mocks/main_category.mocks.dart';
import 'mocks/sub_category.mocks.dart';
import 'models/main_category.dart';
import 'models/sub_category.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late final String _defaultCategory;
  late String _selectedCategory;
  late List<SubCategory> filteredSubCategories;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initLibrary();
    filteredSubCategories = subCategories;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _defaultCategory = 'all';
      _selectedCategory = _defaultCategory;
      _isInitialized = true;
    }
  }

  void selectCategory(category) => setState(() {
        _selectedCategory = category;
        filteredSubCategories = _selectedCategory == _defaultCategory
            ? subCategories
            : subCategories
                .where((subCategory) => subCategory.categories
                    .any((cat) => cat.key == _selectedCategory))
                .toList();
      });

  void showNewPlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const NewPlaylistDialog();
      },
    );
  }

  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  static var user = FirebaseAuth.instance.currentUser!;

  static Future<List<SubCategory>> getPlaylists() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('playlists')
        .orderBy('name', descending: true)
        .where("ownerId", isEqualTo: user.uid)
        .get();

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

  Future<void> initLibrary() async {
    final fromFirebase = await getPlaylists();
    setState(() {
      var subCategoriesSet = Set.from(subCategories);
      var categoriesFromFirebase = Set.from(fromFirebase);
      subCategories =
          List.from(subCategoriesSet.difference(categoriesFromFirebase));
      subCategories.addAll(fromFirebase);
      filteredSubCategories = _selectedCategory == _defaultCategory
          ? subCategories
          : subCategories
              .where((subCategory) => subCategory.categories
                  .any((cat) => cat.key == _selectedCategory))
              .toList();
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.libraryTitle;

    return Scaffold(
        appBar: CustomAppBar(
          title: titleText,
          leading: null,
        ),
        floatingActionButton: SizedBox(
          width: 65,
          height: 65,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'library',
              backgroundColor: AppColors.highlight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.secondaryText),
              ),
              onPressed: () {
                showNewPlaylistDialog(context);
              },
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.text,
                size: 45,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await initLibrary();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainCategoriesChips(
                    selectedCategory: _selectedCategory,
                    mainCategories: mainCategories,
                    onCategorySelected: selectCategory),
                Expanded(
                    child: SubCategoriesGridView(
                        filteredSubCategories: filteredSubCategories)),
              ],
            ),
          ),
        ));
  }
}
