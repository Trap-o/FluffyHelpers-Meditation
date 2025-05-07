import '../models/main_category.dart';

final List<MainCategory> mainCategories = [
  MainCategory(name: "Все"),
  MainCategory(name: "Моє"),
  MainCategory(name: "Релаксація"),
  MainCategory(name: "Фокус"),
  MainCategory(name: "Сон")
];

final Map<String, MainCategory> mainCategoriesMap = {
  for(var category in mainCategories)
    category.name : category
};