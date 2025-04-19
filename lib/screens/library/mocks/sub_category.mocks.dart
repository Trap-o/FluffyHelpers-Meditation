import '../../../constants/app_images_paths.dart';
import '../models/sub_category.dart';
import 'main_category.mocks.dart';

final List<SubCategory> subCategories = [
  SubCategory(name: "Nature sounds", mainCategory: mainCategoriesMap["Relaxation"]!,
      description: "Спокійні звуки природи для глибокого розслаблення та відновлення балансу", pathToImage: AppImagesPaths.backgroundNatureSounds),

  SubCategory(name: "Deep breathing", mainCategory: mainCategoriesMap["Relaxation"]!,
      description: "Вправи з дихання для заспокоєння розуму та зняття напруги", pathToImage: AppImagesPaths.backgroundDeepBreathing),

  SubCategory(name: "Calm music", mainCategory: mainCategoriesMap["Relaxation"]!,
      description: "Мелодії, що сприяють релаксації та створюють атмосферу гармонії", pathToImage: AppImagesPaths.backgroundCalmMusic),

  SubCategory(name: "Lo-Fi", mainCategory: mainCategoriesMap["Focus"]!,
      description: "Легка Lo-Fi музика для підвищення концентрації та продуктивності", pathToImage: AppImagesPaths.backgroundLoFi),

  SubCategory(name: "Mindfulness", mainCategory: mainCategoriesMap["Focus"]!,
      description: "Звукові практики усвідомленості для зосередженості на теперішньому моменті", pathToImage: AppImagesPaths.backgroundMindfulness),

  SubCategory(name: "White noise", mainCategory: mainCategoriesMap["Sleep"]!,
      description: "Білий шум для швидкого засинання та відпочинку без перешкод", pathToImage: AppImagesPaths.backgroundWhiteNoise),

  SubCategory(name: "ASMR", mainCategory: mainCategoriesMap["Sleep"]!,
      description: "Тихі звуки та шепіт для глибокої релаксації та полегшення стресу", pathToImage: AppImagesPaths.backgroundASMR),
];

final Map<String, SubCategory> subCategoriesMap = {
  for(var category in subCategories)
    category.name : category
};