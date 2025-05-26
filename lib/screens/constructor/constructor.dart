import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/app_form_styles.dart';
import '../../constants/app_colors.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';

class Constructor extends StatefulWidget {
  const Constructor({super.key});

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  List<bool> buttonStates = List.generate(20, (_) => false);

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
    Icons.audiotrack,
    FontAwesomeIcons.music,
    Icons.mic,
    FontAwesomeIcons.feather,
    FontAwesomeIcons.sun,
    FontAwesomeIcons.om
  ];

  void _onGridButtonPressed(int index) {
    setState(() {
      buttonStates[index] = !buttonStates[index];
    });

    String soundId = 'sound_$index';
    print('Pressed $soundId');
  }

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
                children: List.generate(20, (index) {
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
                        onPressed: () {
                          _onGridButtonPressed(index);
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: AppColors.secondaryBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => print('Action 1'),
                  child: const Icon(Icons.settings, size: 36),
                ),
                ElevatedButton(
                  onPressed: () => _showInputDialog(context),
                  child: const Icon(Icons.add, size: 36),
                ),
                ElevatedButton(
                  onPressed: () => print('Action 3'),
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
