import 'package:fluffyhelpers_meditation/screens/constructor/variables/sound_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import '../user_mixes_list/mixes_list.dart';
import 'dialogs/new_mix_dialog.dart';

class Constructor extends StatefulWidget {
  const Constructor({super.key});

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  final SoundManager manager = SoundManager();

  late int soundsAmount;
  late List<AudioPlayer> players;
  late Duration mixLength;
  late List<IconData> icons;

  @override
  void initState() {
    super.initState();
    soundsAmount = SoundManager.soundsAmount;
    players = manager.players;
    mixLength = manager.mixLength;
    icons = manager.icons;
  }

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NewMixDialog();
      },
    ).then((_) {
      setState(() {});
    });
  }

  void updateActiveIndices() {
    final newActiveIndices = manager.buttonStates
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    manager.activeIndices = List<int?>.filled(soundsAmount, null);

    for (int i = 0; i < newActiveIndices.length; i++) {
      manager.setActiveIndexAt(i, newActiveIndices[i]);
    }

    setState(() {});
  }

  Future<void> _toggleTrack(int index) async {
    final player = players[index];
    final isPlaying = manager.buttonStates[index];
    final trackPath = 'assets/music/constructor_music_$index.mp3';

    setState(() {
      manager.setButtonStateAt(index, !isPlaying);
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
          manager.setButtonStateAt(index, false);
        });
      }
    } else {
      try {
        await player.setAsset(trackPath);
        await player.setLoopMode(LoopMode.one);
        await player.setVolume(1.0);
        await player.play();
        setState(() {
          manager.setButtonStateAt(index, true);
        });
      } catch (e) {
        print('Помилка програвання: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.constructorTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText, leading: null,),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: List.generate(soundsAmount, (index) {
                  final icon = icons[index % icons.length];
                  final isActive = manager.buttonStates[index];
                  return Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? AppColors.highlight : Colors
                            .transparent,
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
                // ElevatedButton(
                //   onPressed: () => print('Action 1'),
                //   child: const Icon(Icons.settings, size: 36),
                // ),

                ElevatedButton(
                  onPressed: () async {
                    updateActiveIndices();
                    bool allFalse = !manager.buttonStates.contains(true);

                    if(allFalse){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(localizations.snakeBarText),
                          duration: Duration(seconds: 2),
                        ),
                      );

                    }else{
                      _showInputDialog(context);
                    }
                  },
                  child: const Icon(Icons.add, size: 36),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MixedList()),
                    );
                  },
                  child: const Icon(FontAwesomeIcons.bookmark, size: 36),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}