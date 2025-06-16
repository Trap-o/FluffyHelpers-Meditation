import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluffyhelpers_meditation/constants/app_routes.dart';
import 'package:fluffyhelpers_meditation/screens/feed/widgets/post_like_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_text_styles.dart';
import '../../library/mocks/main_category.mocks.dart';
import '../../library/models/main_category.dart';
import '../../library/models/sub_category.dart';
import '../models/post.dart';

class PostsListView extends StatefulWidget {
  final List<Post> posts;

  const PostsListView({super.key, required this.posts});

  @override
  State<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends State<PostsListView> {
  List<SubCategory> playlists = [];
  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<List<SubCategory>> getPlaylists(List<String>? ids) async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection('playlists')
        .where("id", whereIn: ids)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final List<String> categoryKeys = List<String>.from(data['category']);

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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.posts.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 10,
          color: AppColors.accent,
          thickness: 2,
          indent: 10,
          endIndent: 10,
        );
      },
      itemBuilder: (context, index) {
        final post = widget.posts[index];
        final date = post.createdAt;

        return FutureBuilder<List<SubCategory>>(
            future: getPlaylists(post.playlistsIdList),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final playlists = snapshot.data ?? [];
              return Card(
                color: AppColors.secondaryBackground,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        spacing: AppSpacing.small,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              post.ownerAvatar,
                            ),
                          ),
                          Text(post.ownerName, style: AppTextStyles.orderTitle),
                        ],
                      ),
                      const Divider(
                        height: AppSpacing.small,
                        color: AppColors.accent,
                        thickness: 2,
                      ),
                      const SizedBox(height: AppSpacing.small,),
                      Column(
                        children: [
                          Text(
                            post.title ?? '',
                            style: AppTextStyles.title,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: AppSpacing.small,
                          ),
                          Text(
                            post.description ?? '',
                            style: AppTextStyles.body,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: AppSpacing.medium,
                          ),
                            if (playlists.isNotEmpty)
                            SizedBox(
                              height: 150,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.subCategoryDetails,
                                      arguments: playlists.first);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.highlight,
                                      width: 3,
                                    ),
                                    color: AppColors.secondaryBackground,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                          flex: 2,
                                          child: Text(
                                            playlists.first.name,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.setting,
                                          )),
                                      Flexible(
                                        flex: 2,
                                        child: Image.network(
                                          playlists.first.pathToImage,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.small,),
                      const Divider(
                        height: AppSpacing.small,
                        color: AppColors.accent,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              PostLikeButton(
                                postId: post.id,
                              ),
                            ],
                          ),
                          Text(date, style: AppTextStyles.orderTitle),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
