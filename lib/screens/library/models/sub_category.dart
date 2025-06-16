import 'main_category.dart';

class SubCategory {
  final String id;
  final List<String> musicList;
  final String ownerId;
  final String ownerName;
  final String name;
  final List<MainCategory> categories;
  final String description;
  final String pathToImage;

  SubCategory(
      {required this.id,
      required this.musicList,
      required this.ownerId,
      required this.ownerName,
      required this.name,
      required this.categories,
      required this.description,
      required this.pathToImage});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
