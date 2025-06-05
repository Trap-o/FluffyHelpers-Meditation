import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../constructor_icons.dart';

class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;
  SoundManager._internal();

  static const int _soundsAmount = 20;

  final List<bool> _buttonStates = List.generate(_soundsAmount, (_) => false);
  final List<AudioPlayer> _players = List.generate(_soundsAmount, (_) => AudioPlayer());
  final Duration _mixLength = const Duration(minutes: 2);
  final List<int?> _activeIndices = List.filled(_soundsAmount, null);
  final List<IconData> _icons = getIcons();

  static int get soundsAmount => _soundsAmount;
  List<bool> get buttonStates => _buttonStates;
  List<AudioPlayer> get players => _players;
  Duration get mixLength => _mixLength;
  List<int?> get activeIndices => _activeIndices;
  List<IconData> get icons => _icons;

  set activeIndices(List<int?> newIndices) {
    if (newIndices.length == _soundsAmount) {
      for (int i = 0; i < _soundsAmount; i++) {
        _activeIndices[i] = newIndices[i];
      }
    } else {
      throw ArgumentError('Length of newIndices must be $_soundsAmount');
    }
  }

  void setActiveIndexAt(int index, int? value) {
    if (index >= 0 && index < _soundsAmount) {
      _activeIndices[index] = value;
    } else {
      throw RangeError.index(index, _activeIndices, 'index');
    }
  }

  set buttonStates(List<bool> newStates) {
    if (newStates.length == _soundsAmount) {
      for (int i = 0; i < _soundsAmount; i++) {
        _buttonStates[i] = newStates[i];
      }
    } else {
      throw ArgumentError('Length of newStates must be $_soundsAmount');
    }
  }

  void setButtonStateAt(int index, bool value) {
    if (index >= 0 && index < _soundsAmount) {
      _buttonStates[index] = value;
    } else {
      throw RangeError.index(index, _buttonStates, 'index');
    }
  }
}

