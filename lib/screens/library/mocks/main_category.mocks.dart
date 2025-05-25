import '../models/main_category.dart';

final List<MainCategory> mainCategories = [
  MainCategory(key: "all"),
  MainCategory(key: "my"),
  MainCategory(key: "relaxation"),
  MainCategory(key: "focus"),
  MainCategory(key: "sleep")
];

final Map<String, MainCategory> mainCategoriesMap = {
  for(var category in mainCategories)
    category.key : category
};