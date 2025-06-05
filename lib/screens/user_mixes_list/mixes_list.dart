import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'get_mixes_list.dart';

class MixedList extends StatefulWidget {
  const MixedList({super.key});

  @override
  State<MixedList> createState() => _MixedListState();
}

class _MixedListState extends State<MixedList> {
  void _triggerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: localizations.mixesListTitle, leading: null),
      body: GetMixesList(onUpdate: _triggerUpdate),
    );
  }
}