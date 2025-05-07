import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images_paths.dart';
import '../../constants/app_music_paths.dart';
import '../../constants/app_text_styles.dart';
import '../sub_category_details/mocks/playlist_song.mocks.dart';

//const String _titleText = "Player";

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;
  String _song = AppMusicPaths.allPaths.first;
  int _songIndex = 0;
  String _songName = "Null";
  var _songImage = AppImagesPaths.placeholder;
  late var _mock;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _updateSong();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setAsset(_song);
  }

  void _updateSong() {
    setState(() {
      _song = AppMusicPaths.allPaths[_songIndex];
      _mock = playlistSongs.elementAt(_songIndex);
      _songName = _mock.name;
      _songImage = _mock.pathToImage;
    });
    _init();
  }

  void nextSong() {
    if (_songIndex < AppMusicPaths.allPaths.length - 1) {
      _songIndex++;
      _updateSong();
    }
  }

  void previousSong() {
    if (_songIndex > 0) {
      _songIndex--;
      _updateSong();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
        // leading: IconButton(
        //   color: AppColors.accent,
        //   onPressed: () {
        //     Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route) => false);
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      backgroundColor: AppColors.secondaryBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _songImage,
              ),
              const SizedBox(height: 20),
              Text(
                _songName,
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 20),
              StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = _audioPlayer.duration ?? Duration.zero;
                  return Column(
                    children: [
                      Slider(
                        value: position.inSeconds.toDouble(),
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                        activeColor: AppColors.accent,
                      ),
                      Text(
                        "${position.toString().split('.').first} / ${duration.toString().split('.').first}",
                        style: AppTextStyles.body,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous, size: 50),
                        onPressed: previousSong,
                        color: AppColors.accent,
                      ),
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering)
                        const CircularProgressIndicator()
                      else if (playing != true)
                        IconButton(
                          icon: const Icon(Icons.play_arrow, size: 100),
                          onPressed: _audioPlayer.play,
                          color: AppColors.accent,
                        )
                      else if (processingState != ProcessingState.completed)
                        IconButton(
                          icon: const Icon(Icons.pause, size: 100),
                          onPressed: _audioPlayer.pause,
                          color: AppColors.accent,
                        )
                        else
                          IconButton(
                            icon: const Icon(Icons.replay, size: 50),
                            onPressed: () => _audioPlayer.seek(Duration.zero),
                            color: AppColors.accent,
                          ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, size: 50),
                        onPressed: nextSong,
                        color: AppColors.accent,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}