import 'main_category.dart';

class SubCategory{
  final String name;
  final MainCategory mainCategory;
  final String description;
  final String pathToImage;

  SubCategory({required this.name, required this.mainCategory, required this.description, required this.pathToImage});
}