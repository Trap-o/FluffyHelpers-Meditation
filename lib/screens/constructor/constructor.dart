import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/app_form_styles.dart';
import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'mix_compiler.dart';

class Constructor extends StatefulWidget {
  const Constructor({super.key});

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  static const int soundsAmount = 20;
  List<bool> buttonStates = List.generate(soundsAmount, (_) => false);
  List<AudioPlayer> players = List.generate(soundsAmount, (_) => AudioPlayer());
  Duration mixLength = const Duration(minutes: 2);
  List<int?> activeIndices = List.filled(soundsAmount, null);


  final List<IconData> icons = [
    FontAwesomeIcons.dove,
    Icons.music_note,
    Icons.park,
    Icons.eco,
    Icons.water,
    FontAwesomeIcons.fire,
    Icons.air,
    Icons.flash_on,
    Icons.grass,
    Icons.pets,
    FontAwesomeIcons.guitar,
    Icons.record_voice_over,
    Icons.train,
    Icons.library_music,
    FontAwesomeIcons.drum,
    FontAwesomeIcons.music,
    Icons.mic,
    FontAwesomeIcons.feather,
    FontAwesomeIcons.sun,
    FontAwesomeIcons.om
  ];

  void _showInputDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Зберегти композицію'),
          backgroundColor: AppColors.secondaryBackground,
          content: TextField(
            controller: _controller,
            decoration: AppFormStyles.formInputDecorationDefault(
              labelText: 'Введіть назву композиції',
              isError: false
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Скасувати'),
            ),
            ElevatedButton(
              onPressed: () {
                String value = _controller.text;
                print('Введено: $value');
                Navigator.of(context).pop(); //TODO: додати передачу значення
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateActiveIndices(){
    activeIndices = buttonStates
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  void _toggleTrack(int index) async {
    final player = players[index];
    final isPlaying = buttonStates[index];
    final trackPath = 'assets/music/constructor_music_$index.mp3';
    setState(() {
      buttonStates[index] = !buttonStates[index];
    });

    if (isPlaying) {
      try {
        for (double vol = 1.0; vol >= 0.0; vol -= 0.1) {
          await player.setVolume(vol);
          await Future.delayed(const Duration(milliseconds: 50));
        }
        await player.stop();
      } catch (e) {
        print('Помилка зупинки: $e');
      } finally {
        setState(() {
          buttonStates[index] = false;
        });
      }
    } else {
      try {
        await player.setAsset(trackPath);
        await player.setLoopMode(LoopMode.one);
        await player.setVolume(1.0);
        await player.play();
        setState(() {
          buttonStates[index] = true;
        });
      } catch (e) {
        print('Помилка програвання: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child:GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: List.generate(soundsAmount, (index) {
                  final icon = icons[index % icons.length];
                  final isActive = buttonStates[index];
                  return Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? AppColors.highlight : Colors.transparent,
                        border: Border.all(color: AppColors.accent, width: 3),
                      ),
                      child: IconButton(
                        iconSize: 50,
                        icon: Icon(icon, color: AppColors.accent),
                        onPressed: () => _toggleTrack(index),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: AppColors.secondaryBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => print('Action 1'),
                  child: const Icon(Icons.settings, size: 36),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _updateActiveIndices();
                    createMixedTrack(activeIndices, mixLength);

                    for (final player in players) {
                      if (player.playing) {
                        await player.stop();
                      }
                    }

                    for (final player in players) {
                      await player.dispose();
                    }

                    players = List.generate(soundsAmount, (_) => AudioPlayer());

                    for (int i = 0; i < buttonStates.length; i++) {
                      buttonStates[i] = false;
                    }

                    setState(() {});
                    },
                  //_showInputDialog(context)
                  child: const Icon(Icons.add, size: 36),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final file = File('/data/user/0/com.example.flutter_duo_practice/app_flutter/output_mix.mp3');
                    final exists = await file.exists();
                    print('Файл існує? $exists');


                    final dir = await getApplicationDocumentsDirectory();
                    final filePath = '${dir.path}/output_mix.mp3';

                    final mixPlayer = AudioPlayer();
                    await mixPlayer.setFilePath(filePath);
                    await mixPlayer.setVolume(2.5);
                    await mixPlayer.play();
                    print('Запуск програвання');

                    await Future.delayed(const Duration(seconds: 10));

                    await mixPlayer.pause();
                  },
                  child: const Icon(Icons.favorite, size: 36),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
