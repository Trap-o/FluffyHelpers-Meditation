import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_text_styles.dart';
import '../models/sub_category.dart';

class SubCategoriesGridView extends StatelessWidget {
  final List<SubCategory> filteredSubCategories;

  const SubCategoriesGridView({super.key, required this.filteredSubCategories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width / 150).floor(),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          mainAxisExtent: 600
        ),
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
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12)),
                        child: Image.asset(
                          filteredSubCategories[index].pathToImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      flex: 1,
                      child: Text(
                        filteredSubCategories[index].name,
                        style: AppTextStyles.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      )
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      flex: 2,
                      child: Text(
                        filteredSubCategories[index].description,
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      )
                    ),
                  ]
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}