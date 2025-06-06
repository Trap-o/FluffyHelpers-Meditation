import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images_paths.dart';
import '../../constants/app_music_paths.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import '../../services/animal_service/floating_animal.dart';
import '../sub_category_details/mocks/playlist_song.mocks.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../user_mixes_list/list_audio_controller.dart';

class Player extends StatefulWidget {
  final List<Map<String, dynamic>>? mixes;

  const Player({super.key, required this.mixes});

  @override
  State<Player> createState() => _PlayerState();
}

enum RepeatMode {
  none,
  repeatOne,
  repeatAll,
}

class _PlayerState extends State<Player> {
  late AudioPlayer _player;
  int _index = 0;
  bool _isLoading = true;
  RepeatMode _repeatMode = RepeatMode.none;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _handleCompletion();
      }
    });

    if (widget.mixes != null && widget.mixes!.isNotEmpty) {
      _loadCurrent();
    } else {
      _isLoading = false;
    }
  }

  Future<void> _loadCurrent() async {
    final currentMix = widget.mixes![_index];
    final url = currentMix['url'];

    try {
      await _player.setUrl(url);
    } catch (e) {
      print("❌ Audio load error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _next() {
    if (_index < widget.mixes!.length - 1) {
      setState(() {
        _index++;
        _isLoading = true;
      });
      _loadCurrent();
    } else if (_repeatMode == RepeatMode.repeatAll) {
      setState(() {
        _index = 0;
        _isLoading = true;
      });
      _loadCurrent();
    }
  }

  void _prev() {
    if (_index > 0) {
      setState(() {
        _index--;
        _isLoading = true;
      });
      _loadCurrent();
    }
  }

  void _handleCompletion() {
    if (_repeatMode == RepeatMode.repeatOne) {
      _player.seek(Duration.zero);
      _player.play();
    } else {
      _next();
    }
  }

  void _toggleRepeatMode() {
    setState(() {
      _repeatMode = RepeatMode.values[(_repeatMode.index + 1) % RepeatMode.values.length];
    });
  }

  IconData _repeatIcon() {
    switch (_repeatMode) {
      case RepeatMode.repeatOne:
        return Icons.repeat_one;
      case RepeatMode.repeatAll:
        return Icons.repeat;
      case RepeatMode.none:
      default:
        return Icons.repeat;
    }
  }

  Color _repeatColor() {
    return _repeatMode == RepeatMode.none ? AppColors.text : AppColors.accent;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mixes!.isEmpty || widget.mixes == null) {
      return const Scaffold(
        body: Center(child: Text("😕 У вас ще немає композицій")),
      );
    }

    final currentMix = widget.mixes![_index];
    final name = currentMix['name'] ?? 'Unknown';
    final creator = currentMix['creatorName'] ?? currentMix['creatorId'] ?? 'Unknown Creator';

    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),
      body: Stack(
        children: [
          // Плеєр — в центрі екрана
          Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: Theme.of(context).textTheme.headlineSmall),
                Text("by $creator", style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),

                // Слайдер позиції
                StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final duration = _player.duration;

                    if (duration == null || duration.inMilliseconds == 0) {
                      return const SizedBox.shrink();
                    }

                    final posSeconds = position.inSeconds.clamp(0, duration.inSeconds);
                    final durSeconds = duration.inSeconds.toDouble();

                    return Column(
                      children: [
                        Slider(
                          value: posSeconds.toDouble(),
                          max: durSeconds,
                          onChanged: (val) => _player.seek(Duration(seconds: val.toInt())),
                        ),
                        Text(
                          "${position.toString().split('.').first} / ${duration.toString().split('.').first}",
                        ),
                      ],
                    );
                  },
                ),

                // Кнопка play/pause
                StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final playing = state?.playing ?? false;
                    final processing = state?.processingState;

                    final isBuffering = processing == ProcessingState.loading ||
                        processing == ProcessingState.buffering;

                    return IconButton(
                      iconSize: 70,
                      onPressed: isBuffering
                          ? null
                          : () => playing ? _player.pause() : _player.play(),
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            size: 70,
                            color: AppColors.text,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Кнопки керування
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: _prev, icon: const Icon(Icons.skip_previous, size: 40)),
                    const SizedBox(width: 25),
                    IconButton(
                      onPressed: _toggleRepeatMode,
                      icon: Icon(_repeatIcon(), color: _repeatColor(), size: 40),
                      tooltip: "Repeat mode",
                    ),
                    const SizedBox(width: 25),
                    IconButton(onPressed: _next, icon: const Icon(Icons.skip_next, size: 40)),
                  ],
                ),
              ],
            ),
          ),

          // 🐾 Тваринка поверх усього
          FloatingAnimal(),
        ],
      ),
    );

  }
}

