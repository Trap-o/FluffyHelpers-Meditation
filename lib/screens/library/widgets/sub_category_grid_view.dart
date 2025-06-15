import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_spacing.dart';
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
    return Scaffold(
      body: MasonryGridView.count(
          itemCount: filteredSubCategories.length,
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 20,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.subCategoryDetails,
                    arguments: filteredSubCategories[index]);
              },
              child: Card(
                color: AppColors.secondaryBackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side:
                        const BorderSide(width: 2, color: AppColors.accent)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                  imageUrl: filteredSubCategories[index].pathToImage,
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                                // child: filteredSubCategories[index]
                                //         .pathToImage
                                //         .contains("supabase")
                                //     ? Image.network(
                                //         filteredSubCategories[index].pathToImage,
                                //         fit: BoxFit.fitWidth,
                                //       )
                                //     : Image.asset(
                                //         filteredSubCategories[index].pathToImage,
                                //         fit: BoxFit.fitHeight,
                                //       ),
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
                            )),
                        const SizedBox(height: AppSpacing.small),
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
                        const SizedBox(height: AppSpacing.small),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
