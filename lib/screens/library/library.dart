import 'package:fluffyhelpers_meditation/screens/library/widgets/main_category_chips.dart';
import 'package:fluffyhelpers_meditation/screens/library/widgets/sub_category_grid_view.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'dialogs/new_playlist_dialog.dart';
import 'mocks/main_category.mocks.dart';
import 'mocks/sub_category.mocks.dart';
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
      .where((subCategory) =>
        subCategory.mainCategory.key == _selectedCategory)
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.libraryTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText, leading: null,),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.highlight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.secondaryText),
            ),
            onPressed: () {
              showNewPlaylistDialog(context);
            },
            child: const Icon(Icons.add_rounded, color: AppColors.text, size: 45,),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainCategoriesChips(
                selectedCategory: _selectedCategory,
                mainCategories: mainCategories,
                onCategorySelected: selectCategory
              ),
              Expanded(
                child: SubCategoriesGridView(
                  filteredSubCategories: filteredSubCategories
                )
              ),
            ],
          ),
      )
    );
  }
}
