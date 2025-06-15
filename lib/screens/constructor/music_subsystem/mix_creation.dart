import 'package:just_audio/just_audio.dart';
import '../../../services/level_service/level_manager.dart';
import 'mix_compiler.dart';
import 'package:fluffyhelpers_meditation/screens/constructor/variables/sound_manager.dart';

Future<void> createSoundMix() async {
  final manager = SoundManager();
  final activeIndices = manager.activeIndices;
  final mixLength = manager.mixLength;
  final players = manager.players;
  final buttonStates = manager.buttonStates;

  createMixedTrack(activeIndices, mixLength);
  LevelManager.instance.addExp(15);

  for (final player in players) {
    if (player.playing) {
      await player.stop();
    }
    await player.dispose();
  }

  for (int i = 0; i < players.length; i++) {
    players[i] = AudioPlayer();
  }

  for (int i = 0; i < buttonStates.length; i++) {
    manager.setButtonStateAt(i, false);
  }

  for (int i = 0; i < activeIndices.length; i++) {
    manager.setActiveIndexAt(i, null);
  }
}


