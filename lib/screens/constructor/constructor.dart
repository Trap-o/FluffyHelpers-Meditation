import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';

class Constructor extends StatefulWidget {
  const Constructor({super.key});

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.constructorTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText, leading: null,),
      body: const Column(
        children: [
        ],
      ),
    );
  }
}