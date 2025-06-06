import 'package:uuid/uuid.dart';

import '../../../constants/app_images_paths.dart';
import '../models/sub_category.dart';
import 'main_category.mocks.dart';

const uuid = Uuid();
List<SubCategory> subCategories = [
  SubCategory(
    name: "nature_sounds",
    categories: [mainCategoriesMap["relaxation"]!],
    description: "nature_sounds_desc",
    pathToImage: AppImagesPaths.backgroundNatureSounds,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "deep_breathing",
    categories: [mainCategoriesMap["relaxation"]!],
    description: "deep_breathing_desc",
    pathToImage: AppImagesPaths.backgroundDeepBreathing,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "calm_music",
    categories: [mainCategoriesMap["relaxation"]!],
    description: "calm_music_desc",
    pathToImage: AppImagesPaths.backgroundCalmMusic,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "lofi",
    categories: [mainCategoriesMap["focus"]!],
    description: "lofi_desc",
    pathToImage: AppImagesPaths.backgroundLoFi,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "mindfulness",
    categories: [mainCategoriesMap["focus"]!],
    description: "mindfulness_desc",
    pathToImage: AppImagesPaths.backgroundMindfulness,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "white_noise",
    categories: [mainCategoriesMap["sleep"]!],
    description: "white_noise_desc",
    pathToImage: AppImagesPaths.backgroundWhiteNoise,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),

  SubCategory(
    name: "asmr",
    categories: [mainCategoriesMap["sleep"]!],
    description: "asmr_desc",
    pathToImage: AppImagesPaths.backgroundASMR,
    id: uuid.v4(),
    musicList: [],
    ownerId: uuid.v4(),
    ownerName: "FluffyHelpers",
  ),
];

final Map<String, SubCategory> subCategoriesMap = {
  for(var category in subCategories)
    category.name : category
};