import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class PostLikeButton extends StatefulWidget {
  final String postId;

  const PostLikeButton({super.key, required this.postId});

  @override
  State<StatefulWidget> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  final authInstance = FirebaseAuth.instance;
  final storeInstance = FirebaseFirestore.instance;
  late String userId;
  String? realDocId;
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    userId = authInstance.currentUser!.uid;
    _loadInitialButtonState();
  }

  Future<void> _loadInitialButtonState() async {
    final postQuerySnapshot = await storeInstance
        .collection('posts')
        .where("id", isEqualTo: widget.postId)
        .limit(1)
        .get();
    if (postQuerySnapshot.docs.isEmpty) return;

    final postDoc = postQuerySnapshot.docs.first;
    realDocId = postDoc.id;
    final postData = postDoc.data();
    final likeDocData =
        await postDoc.reference.collection('likes').doc(userId).get();

    setState(() {
      likeCount = postData['likesNumber'];
      isLiked = likeDocData.exists;
    });
  }

  Future<void> _toggleLike() async {
    if (realDocId == null) return;

    final postRef = storeInstance.collection('posts').doc(realDocId);
    final likeRef = postRef.collection('likes').doc(userId);

    await storeInstance.runTransaction((trans) async {
      final postSnap = await trans.get(postRef);
      final likeSnap = await trans.get(likeRef);

      final currentLikesNumber = postSnap.data()?['likesNumber'];

      if (likeSnap.exists) {
        trans.delete(likeRef);
        trans.update(postRef, {'likesNumber': currentLikesNumber - 1});
        setState(() {
          isLiked = false;
          likeCount--;
        });
      } else {
        trans.set(likeRef, {'likedAt': FieldValue.serverTimestamp()});
        trans.update(postRef, {'likesNumber': currentLikesNumber + 1});
        setState(() {
          isLiked = true;
          likeCount++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (realDocId == null) {
      return const CircularProgressIndicator();
    } // ????
    return Row(
      children: [
        IconButton(
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
              size: 25, color: AppColors.text),
          onPressed: _toggleLike,
        ),
        const SizedBox(width: 4),
        Text("$likeCount"),
      ],
    );
  }
}
