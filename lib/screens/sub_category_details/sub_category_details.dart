import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import '../library/mocks/main_category.mocks.dart';
import '../library/models/main_category.dart';
import '../library/models/sub_category.dart';
import 'get_playlist.dart';
import 'mocks/playlist_song.mocks.dart';
import 'models/playlist_song.dart';

late String subCategoryId;

class SubCategoryDetails extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryDetails({super.key, required this.subCategory});

  List<PlaylistSong> filterMusic() => playlistSongs
      .where((song) => song.relatedSubCategory == subCategory.id)
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
    subCategoryId = subCategory.id;

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
              child: subCategory.pathToImage
                      .contains("supabase") // TODO пофіксити фото
                  ? Image.network(
                      subCategory.pathToImage,
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
                      subCategory.pathToImage,
                      fit: BoxFit.fitHeight,
                    ),
            ),
          )),
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

  List<SubCategory> subCategories = [];
  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  static Future<List<SubCategory>> getPlaylists() async {
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection('playlists').
        where("id", isEqualTo: subCategoryId)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final List<String> categoryKeys = List<String>.from(data['category']);
      print(data['id']);

      return SubCategory(
        id: data['id'],
        name: data['name'],
        musicList: List<String>.from(data['musicList']),
        ownerId: data['ownerId'],
        ownerName: data['ownerName'],
        categories: categoryKeys
            .map((key) => mainCategoriesMap[key])
            .where((cat) => cat != null)
            .cast<MainCategory>()
            .toList(),
        description: data['description'],
        pathToImage: data['imageUrl'],
      );
    }).toList();
  }

  Future<void> initPlaylist() async {
    final fromFirebase = await getPlaylists();
    setState(() {
      subCategories = fromFirebase;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    print('subCategoryId: "$subCategoryId"');
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await initPlaylist();
        },
        child: GetPlaylist(
          onUpdate: _triggerUpdate,
          playlistId: subCategories.first.id
        )
      ),
    );
  }
}
