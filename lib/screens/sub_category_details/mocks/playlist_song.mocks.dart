import '../../../constants/app_music_paths.dart';
import '../../home/mocks/sub_category.mocks.dart';
import '../models/playlist_song.dart';

final List<PlaylistSong> playlistSongs = [
  PlaylistSong(name: "Calm Soul", duration: "4.00хв", isLiked: false, pathToMusic: AppMusicPaths.calmSoul,
      relatedSubCategory: subCategoriesMap["Nature sounds"]!.name, pathToImage: subCategoriesMap["Nature sounds"]!.pathToImage),

  PlaylistSong(name: "Blue", duration: "1.21хв", isLiked: true, pathToMusic: AppMusicPaths.blue,
      relatedSubCategory: subCategoriesMap["Nature sounds"]!.name, pathToImage: subCategoriesMap["Nature sounds"]!.pathToImage),

  PlaylistSong(name: "Awesome ambient", duration: "6.52хв", isLiked: false, pathToMusic: AppMusicPaths.meditMusic,
      relatedSubCategory: subCategoriesMap["Calm music"]!.name, pathToImage: subCategoriesMap["Calm music"]!.pathToImage),

  PlaylistSong(name: "Relaxing", duration: "6.07хв", isLiked: false, pathToMusic: AppMusicPaths.relaxing,
      relatedSubCategory: subCategoriesMap["White noise"]!.name, pathToImage: subCategoriesMap["White noise"]!.pathToImage),

  PlaylistSong(name: "Serenity Waves", duration: "4.00хв", isLiked: true, pathToMusic: AppMusicPaths.serenityWavesZen,
      relatedSubCategory: subCategoriesMap["Deep breathing"]!.name, pathToImage: subCategoriesMap["Deep breathing"]!.pathToImage),

  PlaylistSong(name: "Spiritual Yoga", duration: "3.12", isLiked: false, pathToMusic: AppMusicPaths.zenSpiritualYogaMassage,
      relatedSubCategory: subCategoriesMap["Nature sounds"]!.name, pathToImage: subCategoriesMap["Nature sounds"]!.pathToImage),
];