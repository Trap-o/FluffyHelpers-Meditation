import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import '../library/models/sub_category.dart';
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
                child: subCategory.pathToImage.contains("supabase")
                    ? Image.network(
                        subCategory.pathToImage,
                        fit: BoxFit.fitWidth,
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
          )
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
  void toggleLikedState(int index) {
    return setState(() {
      widget.filteredMusic[index].isLiked =
          !widget.filteredMusic[index].isLiked;
    });
  }

  IconData changeLikedIcon(bool isLiked) {
    return isLiked ? Icons.favorite : Icons.favorite_border;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.filteredMusic.length,
      itemBuilder: (context, index) {
        final song = widget.filteredMusic[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.player);
          },
          child: Card(
            color: AppColors.secondaryBackground,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.name,
                          style: AppTextStyles.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          song.duration,
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_fill_rounded,
                      //changeLikedIcon(song.isLiked),
                      size: 50,
                    ),
                    color: AppColors.highlight,
                    onPressed: () {
                      toggleLikedState(index);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
