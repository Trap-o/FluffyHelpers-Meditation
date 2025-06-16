import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  String? _currentUrl;
  int _currentIndex = 0;

  String? get currentUrl => _currentUrl;
  int get currentIndex => _currentIndex;

  bool get isPlaying => player.playing;

  void setCurrentUrl(String url, {required int index}) {
    _currentUrl = url;
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> playMix(String url, {required int index}) async {
    notifyListeners();
    if (_currentUrl == url) {
      if (player.playing) {
        await player.pause();
      } else {
        await player.play();
      }
    } else {
      await player.setUrl(url);
      _currentUrl = url;
      _currentIndex = index;
      await player.play();
    }
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

