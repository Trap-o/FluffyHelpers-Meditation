import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../models/main_category.dart';

class MainCategoriesChips extends StatelessWidget {
  final List<MainCategory> mainCategories;
  final String? selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const MainCategoriesChips(
    {super.key,
      required this.selectedCategory,
      required this.mainCategories,
      required this.onCategorySelected}
    );

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mainCategories.map((mainCategory) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ChoiceChip(
              label: Text(localizations.mainCategory(mainCategory.key)),
              labelStyle: AppTextStyles.buttonPrimary,
              showCheckmark: false,
              backgroundColor: AppColors.secondaryBackground,
              selectedColor: AppColors.accent,
              selected: selectedCategory == mainCategory.key,
              onSelected: (bool selected) {
                onCategorySelected(mainCategory.key);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}