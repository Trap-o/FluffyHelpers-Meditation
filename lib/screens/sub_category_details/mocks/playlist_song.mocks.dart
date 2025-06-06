import '../../../constants/app_music_paths.dart';
import '../../library/mocks/sub_category.mocks.dart';
import '../models/playlist_song.dart';

final List<PlaylistSong> playlistSongs = [
  PlaylistSong(name: "Calm Soul", duration: "4.00", isLiked: false, pathToMusic: AppMusicPaths.calmSoul,
      relatedSubCategory: subCategoriesMap["nature_sounds"]!.name, pathToImage: subCategoriesMap["nature_sounds"]!.pathToImage),

  PlaylistSong(name: "Blue", duration: "1.21", isLiked: true, pathToMusic: AppMusicPaths.blue,
      relatedSubCategory: subCategoriesMap["nature_sounds"]!.name, pathToImage: subCategoriesMap["nature_sounds"]!.pathToImage),

  PlaylistSong(name: "Awesome ambient", duration: "6.52", isLiked: false, pathToMusic: AppMusicPaths.meditMusic,
      relatedSubCategory: subCategoriesMap["calm_music"]!.name, pathToImage: subCategoriesMap["calm_music"]!.pathToImage),

  PlaylistSong(name: "Relaxing", duration: "6.07", isLiked: false, pathToMusic: AppMusicPaths.relaxing,
      relatedSubCategory: subCategoriesMap["white_noise"]!.name, pathToImage: subCategoriesMap["white_noise"]!.pathToImage),

  PlaylistSong(name: "Serenity Waves", duration: "4.00", isLiked: true, pathToMusic: AppMusicPaths.serenityWavesZen,
      relatedSubCategory: subCategoriesMap["deep_breathing"]!.name, pathToImage: subCategoriesMap["deep_breathing"]!.pathToImage),

  PlaylistSong(name: "Spiritual Yoga", duration: "3.12", isLiked: false, pathToMusic: AppMusicPaths.zenSpiritualYogaMassage,
      relatedSubCategory: subCategoriesMap["nature_sounds"]!.name, pathToImage: subCategoriesMap["nature_sounds"]!.pathToImage),
];