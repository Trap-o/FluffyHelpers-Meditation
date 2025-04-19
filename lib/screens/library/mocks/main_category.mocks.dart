import '../models/main_category.dart';

final List<MainCategory> mainCategories = [
  MainCategory(name: "All"),
  MainCategory(name: "Relaxation"),
  MainCategory(name: "Focus"),
  MainCategory(name: "Sleep")
];

final Map<String, MainCategory> mainCategoriesMap = {
  for(var category in mainCategories)
    category.name : category
};