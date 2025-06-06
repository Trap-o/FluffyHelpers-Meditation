import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../models/sub_category.dart';

class SubCategoriesGridView extends StatelessWidget {
  final List<SubCategory> filteredSubCategories;

  const SubCategoriesGridView({super.key, required this.filteredSubCategories});

  String translateSubCategoryName(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    final knownKeys = {
      'nature_sounds',
      'deep_breathing',
      'calm_music',
      'lofi',
      'mindfulness',
      'white_noise',
      'asmr',
    };

    return knownKeys.contains(key) ? localizations.subCategoryName(key) : key;
  }

  String translateSubCategoryDescription(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    final knownKeys = {
      'nature_sounds_desc',
      'deep_breathing_desc',
      'calm_music_desc',
      'lofi_desc',
      'mindfulness_desc',
      'white_noise_desc',
      'asmr_desc',
    };

    return knownKeys.contains(key)
        ? localizations.subCategoryDesciption(key)
        : key;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width / 150).floor(),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 600),
          itemCount: filteredSubCategories.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.subCategoryDetails,
                    arguments: filteredSubCategories[index]);
              },
              child: Card(
                elevation: 6,
                color: AppColors.secondaryBackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: filteredSubCategories[index]
                                      .pathToImage
                                      .contains("supabase")
                                  ? Image.network(
                                      filteredSubCategories[index].pathToImage,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.asset(
                                      filteredSubCategories[index].pathToImage,
                                      fit: BoxFit.fitHeight,
                                    ),
                            )),
                        const SizedBox(height: 20),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              translateSubCategoryName(
                                  context, filteredSubCategories[index].name),
                              style: AppTextStyles.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                          )
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              translateSubCategoryDescription(context,
                                  filteredSubCategories[index].description),
                              style: AppTextStyles.orderTitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
