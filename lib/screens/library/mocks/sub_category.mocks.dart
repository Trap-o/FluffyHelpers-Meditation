import '../../../constants/app_images_paths.dart';
import '../models/sub_category.dart';
import 'main_category.mocks.dart';

final List<SubCategory> subCategories = [ // перейменування через key як в мейнкатегорі
  SubCategory(name: "Звуки природи", mainCategory: mainCategoriesMap["relaxation"]!,
    description: "Спокійні звуки природи для глибокого розслаблення та відновлення балансу", pathToImage: AppImagesPaths.backgroundNatureSounds),

  SubCategory(name: "Глибоке дихання", mainCategory: mainCategoriesMap["relaxation"]!,
    description: "Вправи з дихання для заспокоєння розуму та зняття напруги", pathToImage: AppImagesPaths.backgroundDeepBreathing),

  SubCategory(name: "Спокійна музика", mainCategory: mainCategoriesMap["relaxation"]!,
    description: "Мелодії, що сприяють релаксації та створюють атмосферу гармонії", pathToImage: AppImagesPaths.backgroundCalmMusic),

  SubCategory(name: "Lo-Fi", mainCategory: mainCategoriesMap["focus"]!,
    description: "Легка Lo-Fi музика для підвищення концентрації та продуктивності", pathToImage: AppImagesPaths.backgroundLoFi),

  SubCategory(name: "Зосередження", mainCategory: mainCategoriesMap["focus"]!,
    description: "Звукові практики усвідомленості для зосередженості на теперішньому моменті", pathToImage: AppImagesPaths.backgroundMindfulness),

  SubCategory(name: "Білий шум", mainCategory: mainCategoriesMap["sleep"]!,
    description: "Білий шум для швидкого засинання та відпочинку без перешкод", pathToImage: AppImagesPaths.backgroundWhiteNoise),

  SubCategory(name: "ASMR", mainCategory: mainCategoriesMap["sleep"]!,
    description: "Тихі звуки та шепіт для глибокої релаксації та полегшення стресу", pathToImage: AppImagesPaths.backgroundASMR),
];

final Map<String, SubCategory> subCategoriesMap = {
  for(var category in subCategories)
    category.name : category
};