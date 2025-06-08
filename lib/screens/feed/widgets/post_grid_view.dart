import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../models/post.dart';

class PostsListView extends StatelessWidget {
  final List<Post> posts;

  const PostsListView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final post = posts[index];
        final date = post.createdAt;

        return Card(
          color: AppColors.secondaryBackground,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        post.ownerAvatar,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(post.ownerName, style: AppTextStyles.title),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        post.title ?? '',
                        style: AppTextStyles.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Text(
                        post.description ?? '',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.right,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite, size: 25, color: AppColors.text),
                        const SizedBox(width: 4),
                        Text(post.likesNumber.toString()),
                      ],
                    ),
                    Text(date, style: AppTextStyles.orderTitle),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}