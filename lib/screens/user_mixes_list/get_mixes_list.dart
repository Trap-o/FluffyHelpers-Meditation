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

          final audioController = context.watch<AudioController>();

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: mixes.length,
            itemBuilder: (context, index) {
              final mix = mixes[index];

              final isCurrent = audioController.currentUrl == mix['url'];
              final isPlaying = audioController.isPlaying;

              return GestureDetector(
                onTap: () {
                  audioController.playMix(mix['url'], index: index);
                  widget.onUpdate?.call();
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
                                mix['name'] ?? 'No Name',
                                style: AppTextStyles.title.copyWith(
                                  color: isCurrent
                                      ? AppColors.accent
                                      : AppColors.text,
                                  fontWeight: isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                mix['creatorName'] ?? 'Unknown Creator',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isCurrent && isPlaying
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_fill_rounded,
                            size: 50,
                          ),
                          color:
                          isCurrent ? AppColors.accent : AppColors.highlight,
                          onPressed: () {
                            audioController.playMix(mix['url'], index: index);
                            widget.onUpdate?.call();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

