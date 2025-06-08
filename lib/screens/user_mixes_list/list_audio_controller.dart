import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends ChangeNotifier {

  AudioController._internal() {
    _player.playerStateStream.listen((state) {
      final playing = state.playing && state.processingState == ProcessingState.ready;
      if (playing != _isPlaying) {
        _isPlaying = playing;
        notifyListeners();
      }
    });
  }

  static final AudioController _instance = AudioController._internal();

  factory AudioController() => _instance;

  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  String? _currentUrl;
  bool _isPlaying = false;

  String? get currentUrl => _currentUrl;
  bool get isPlaying => _isPlaying;

  void play() {
    _isPlaying = true;
  }

  void stop() {
    _isPlaying = false;
  }

  Future<void> handleTap(String url) async {
    try {
      if (_currentUrl == url) {
        if (_isPlaying) {
          await _player.pause();
        } else {
          await _player.play();
        }
      } else {
        await _player.stop();
        await _player.setUrl(url);
        _currentUrl = url;
        await _player.play();
      }
    } catch (e) {
      print('Audio error: $e');
    }

    notifyListeners();
  }

  void disposePlayer() {
    _player.dispose();
  }
}

