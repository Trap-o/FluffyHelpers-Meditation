import 'package:fluffyhelpers_meditation/screens/constructor/variables/sound_manager.dart';
import 'package:fluffyhelpers_meditation/screens/user_mixes_list/list_audio_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SoundManager basic tests', () {
    late SoundManager soundManager;
    setUp(() {
      soundManager = SoundManager();
    });

    test('Initial buttonStates all false', () {
      expect(soundManager.buttonStates.every((state) => state == false), isTrue);
    });
    test('Setting active index at valid position works', () {
      soundManager.setActiveIndexAt(0, 2);
      expect(soundManager.activeIndices[0], 2);
    });
    test('Setting active index at invalid position throws RangeError', () {
      expect(() => soundManager.setActiveIndexAt(999, 1), throwsRangeError);
    });
    test('Setting button state at valid position works', () {
      soundManager.setButtonStateAt(1, true);
      expect(soundManager.buttonStates[1], isTrue);
    });
    test('Setting button state at invalid position throws RangeError', () {
      expect(() => soundManager.setButtonStateAt(1000, true), throwsRangeError);
    });
  });

  group('AudioController basic tests', () {
    late AudioController controller;
    setUp(() {
      controller = AudioController();
    });

    test('Initial state: currentUrl null and isPlaying false', () {
      expect(controller.currentUrl, isNull);
      expect(controller.isPlaying, isFalse);
    });
    test('can update isPlaying manually (basic state test)', () {
      controller.play();
      expect(controller.isPlaying, isTrue);
      controller.stop();
      expect(controller.isPlaying, isFalse);
    });
  });
}
