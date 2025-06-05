import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffyhelpers_meditation/constants/app_colors.dart';
import 'package:fluffyhelpers_meditation/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_audio_controller.dart';
import 'mixes_fetching.dart';

class GetMixesList extends StatefulWidget {
  final VoidCallback? onUpdate;

  const GetMixesList({super.key, this.onUpdate});

  @override
  State<GetMixesList> createState() => _GetMixesListState();
}


class _GetMixesListState extends State<GetMixesList> {
  late Future<List<Map<String, dynamic>>> _futureMixes;
  final _fetcher = MixesFetching();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _futureMixes = _fetcher.fetchMixesByUser(user.uid);
    }
  }

  Future<void> _refresh() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _futureMixes = _fetcher.fetchMixesByUser(user.uid);
      });
      widget.onUpdate?.call();
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('User not logged in'));
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureMixes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final mixes = snapshot.data ?? [];

          if (mixes.isEmpty) {
            return const Center(child: Text('No music found.'));
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: mixes.length,
            itemBuilder: (context, index) {
              final mix = mixes[index];
              final audioController = context.watch<AudioController>();

              final isCurrent = audioController.currentUrl == mix['url'];
              final isPlaying = audioController.isPlaying;

              return ListTile(
                title: Text(mix['name'] ?? 'No Name',
                  style: AppTextStyles.body.copyWith(
                    color: isCurrent ? AppColors.accent : AppColors.text,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),),
                subtitle: Text(mix['creatorName'] ?? 'Unknown Creator', style: AppTextStyles.body),
                trailing: Icon(
                  isCurrent && isPlaying ? Icons.pause : Icons.play_arrow,
                  color: isCurrent ? AppColors.accent : AppColors.text,
                ),
                onTap: () {
                  audioController.handleTap(mix['url']);
                  widget.onUpdate?.call();
                },
              );
            },
          );
        },
      ),
    );
  }
}

