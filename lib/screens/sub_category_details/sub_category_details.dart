import 'package:flutter/material.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import '../library/models/sub_category.dart';
import 'get_playlist.dart';
import 'mocks/playlist_song.mocks.dart';
import 'models/playlist_song.dart';

class SubCategoryDetails extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryDetails({super.key, required this.subCategory});

  List<PlaylistSong> filterMusic() => playlistSongs
      .where((song) => song.relatedSubCategory == subCategory.name)
      .toList();

  String translateSubCategoryName(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    final knownKeys = {
      'nature_sounds',
      'deep_breathing',
      'calm_music',
      'lofi',
      'mindfulness',
      'white_noise',
      'asmr',
    };

    return knownKeys.contains(key) ? localizations.subCategoryName(key) : key;
  }

  @override
  Widget build(BuildContext context) {

    final filteredMusic = filterMusic();
    final titleText = translateSubCategoryName(context, subCategory.name);

    return Scaffold(
      appBar: CustomAppBar(
        title: titleText,
        leading: null,
      ),
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                height: MediaQuery.of(context).size.width - 20,
                width: MediaQuery.of(context).size.width - 20,
                child: subCategory.pathToImage.contains("supabase") // TODO пофіксити фото
                    ? Image.network(
                        subCategory.pathToImage,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.asset(
                        subCategory.pathToImage,
                        fit: BoxFit.fitHeight,
                      ),
              ),
            )
          ),
          const SizedBox(height: 20),
          Expanded(
            child: MusicListView(filteredMusic: filteredMusic),
          ),
        ],
      ),
    );
  }
}


class MusicListView extends StatefulWidget {
  final List<PlaylistSong> filteredMusic;

  const MusicListView({super.key, required this.filteredMusic});

  @override
  State<MusicListView> createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {

  void _triggerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: сюди зробити передачу айді
      //body: GetPlaylist(onUpdate: _triggerUpdate, playlistId: ),
    );
  }
}
