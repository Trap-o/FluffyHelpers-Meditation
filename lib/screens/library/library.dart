import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_text_styles.dart';
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
  final String _defaultCategory = "Все";
  final String _titleText = "Бібліотека";
  late String _selectedCategory;
  late List<SubCategory> filteredSubCategories;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _defaultCategory;
    filteredSubCategories = subCategories;
  }

  void selectCategory(category) => setState(() {
    _selectedCategory = category;
    filteredSubCategories = _selectedCategory == _defaultCategory
      ? subCategories
      : subCategories
      .where((subCategory) =>
        subCategory.mainCategory.name == _selectedCategory)
          .toList();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleText),
        backgroundColor: AppColors.primaryBackground,
        titleTextStyle: AppTextStyles.title,
        centerTitle: true,
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
              )
            ],
          ),
      )
    );
  }
}

class MainCategoriesChips extends StatelessWidget {
  final List<MainCategory> mainCategories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const MainCategoriesChips(
    {super.key,
    required this.selectedCategory,
    required this.mainCategories,
    required this.onCategorySelected}
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mainCategories.map((mainCategory) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ChoiceChip(
              label: Text(mainCategory.name),
              labelStyle: AppTextStyles.buttonPrimary,
              showCheckmark: false,
              backgroundColor: AppColors.secondaryBackground,
              selectedColor: AppColors.accent,
              selected: selectedCategory == mainCategory.name,
              onSelected: (bool selected) {
                onCategorySelected(mainCategory.name);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SubCategoriesGridView extends StatelessWidget {
  final List<SubCategory> filteredSubCategories;

  const SubCategoriesGridView({super.key, required this.filteredSubCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
