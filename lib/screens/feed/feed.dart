import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.feedTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText, leading: null,),
      body: const Column(
        children: [
        ],
      ),
    );
  }
}