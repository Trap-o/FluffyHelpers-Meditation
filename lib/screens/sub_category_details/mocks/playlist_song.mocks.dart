import '../../../constants/app_music_paths.dart';
import '../../library/mocks/sub_category.mocks.dart';
import '../models/playlist_song.dart';

final List<PlaylistSong> playlistSongs = [
  PlaylistSong(name: "Calm Soul", duration: "4.00хв", isLiked: false, pathToMusic: AppMusicPaths.calmSoul,
      relatedSubCategory: subCategoriesMap["Звуки природи"]!.name, pathToImage: subCategoriesMap["Звуки природи"]!.pathToImage),

  PlaylistSong(name: "Blue", duration: "1.21хв", isLiked: true, pathToMusic: AppMusicPaths.blue,
      relatedSubCategory: subCategoriesMap["Звуки природи"]!.name, pathToImage: subCategoriesMap["Звуки природи"]!.pathToImage),

  PlaylistSong(name: "Awesome ambient", duration: "6.52хв", isLiked: false, pathToMusic: AppMusicPaths.meditMusic,
      relatedSubCategory: subCategoriesMap["Спокійна музика"]!.name, pathToImage: subCategoriesMap["Спокійна музика"]!.pathToImage),

  PlaylistSong(name: "Relaxing", duration: "6.07хв", isLiked: false, pathToMusic: AppMusicPaths.relaxing,
      relatedSubCategory: subCategoriesMap["Білий шум"]!.name, pathToImage: subCategoriesMap["Білий шум"]!.pathToImage),

  PlaylistSong(name: "Serenity Waves", duration: "4.00хв", isLiked: true, pathToMusic: AppMusicPaths.serenityWavesZen,
      relatedSubCategory: subCategoriesMap["Глибоке дихання"]!.name, pathToImage: subCategoriesMap["Глибоке дихання"]!.pathToImage),

  PlaylistSong(name: "Spiritual Yoga", duration: "3.12", isLiked: false, pathToMusic: AppMusicPaths.zenSpiritualYogaMassage,
      relatedSubCategory: subCategoriesMap["Звуки природи"]!.name, pathToImage: subCategoriesMap["Звуки природи"]!.pathToImage),
];