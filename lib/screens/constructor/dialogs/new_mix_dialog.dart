import 'package:fluffyhelpers_meditation/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_button_styles.dart';
import '../../../constants/app_form_styles.dart';
import '../../../constants/app_text_styles.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.8;

        return AlertDialog(
          backgroundColor: AppColors.secondaryBackground,
          content: SizedBox(
            width: maxWidth,
            child: TextField(
              controller: controller,
              maxLength: 25,
              decoration: AppFormStyles.formInputDecorationDefault(
                labelText: localizations.mixNameText,
                isError: false,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String value = controller.text.trim();

                if (value.isEmpty) return;

                try {
                  await createSoundMix();
                } catch (e, stack) {
                  print('createSoundMix error: $e\n$stack');
                }

            if(context.mounted){ // використав для уникнення помилки Don't use 'BuildContext' across async gaps
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }

                await Future.delayed(const Duration(seconds: 5));

                try {
                  mixUploading.loadMixToFirebase(
                    value,
                    await mixUploading.loadMixToSupabase(),
                  );
                } catch (e, stack) {
                  print('Uploading error: $e\n$stack');
                }

                navigator.pop();
                navigator.pop();
              },
              style: AppButtonStyles.primary,
              child: Text(localizations.okButton, style: AppTextStyles.buttonPrimary),
            ),

            ElevatedButton(
              onPressed: () {
                navigator.pop();
              },
              style: AppButtonStyles.delete,
              child: Text(localizations.cancelButton, style: AppTextStyles.buttonSecondary),
            ),
          ],
        );
      },
    );
  }
}
