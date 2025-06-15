import 'package:fluffyhelpers_meditation/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_form_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../music_subsystem/mix_creation.dart';
import '../music_subsystem/mix_uploading.dart';

class NewMixDialog extends StatelessWidget {
  const NewMixDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController();
    final navigator = Navigator.of(context);

    final MixUploading mixUploading = MixUploading();

    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      content: TextField(
        controller: controller,
        decoration: AppFormStyles.formInputDecorationDefault(
          labelText: localizations.mixNameText,
          isError: false,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            navigator.pop();
          },
          child: Text(localizations.cancelButton),
        ),
        ElevatedButton(
          onPressed: () async {
            String value = controller.text;

            try {
              await createSoundMix();
            }catch(e, stack){
              print('❌ createSoundMix error: $e\n$stack');
            }

            print('Введено: $value');

            showDialog(
              context: context, // TODO придумати як пофіксити
              barrierDismissible: false,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            await Future.delayed(const Duration(seconds: 5));

            try {
              mixUploading.loadMixToFirebase(
                value,
                await mixUploading.loadMixToSupabase(),
              );
            }catch(e, stack){
              print('❌ Uploading error: $e\n$stack');
            }

            navigator.pop();
            navigator.pop();
          },
          child: Text(localizations.okButton),
        ),
      ],
    );
  }
}
