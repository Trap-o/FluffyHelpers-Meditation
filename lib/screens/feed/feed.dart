import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluffyhelpers_meditation/screens/feed/widgets/post_grid_view.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'models/post.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> posts = [];
  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  static Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Post(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        playlistsIdList: List<String>.from(data['playlistList']),
        ownerId: data['ownerId'],
        ownerName: data['ownerName'],
        ownerAvatar: data['ownerAvatar'],
        likesNumber: data['likesNumber'],
        createdAt: data['createdAt'],
      );
    }).toList();
  }

  Future<void> initFeed() async {
    final fromFirebase = await getPosts();
    setState(() {
      posts = fromFirebase;
    });
  }

  @override
  void initState() {
    super.initState();
    initFeed();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.feedTitle;

    return Scaffold(
        appBar: CustomAppBar(
          title: titleText,
          leading: null,
        ),
        floatingActionButton: SizedBox(
          width: 65,
          height: 65,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'feed',
              backgroundColor: AppColors.highlight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.secondaryText),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/postCreator');
              },
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.text,
                size: 45,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await initFeed();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: PostsListView(posts: posts),
                ),
              ],
            ),
          ),
        ));
  }
}
