import 'package:fluffyhelpers_meditation/constants/app_button_styles.dart';
import 'package:fluffyhelpers_meditation/constants/app_colors.dart';
import 'package:fluffyhelpers_meditation/constants/app_spacing.dart';
import 'package:fluffyhelpers_meditation/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_routes.dart';
import '../../../l10n/app_localizations.dart';

class NewPlaylistDialog extends StatelessWidget {

  const NewPlaylistDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final TextEditingController nameController = TextEditingController();

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      backgroundColor: AppColors.primaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(localizations.playlistNameText, style: AppTextStyles.title,),
            const SizedBox(height: AppSpacing.small,),
            TextFormField(controller: nameController,),
            const SizedBox(height: AppSpacing.small,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.playlistCreator, arguments: nameController.text);
                  },
                  style: AppButtonStyles.primary,
                  child: Text(localizations.okButton, style: AppTextStyles.buttonPrimary,),
                ),
                const SizedBox(width: AppSpacing.large,),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: AppButtonStyles.delete,
                  child: Text(localizations.cancelButton, style: AppTextStyles.buttonSecondary,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}