import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';

const String _titleText = "Стрічка";

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _titleText, leading: null,),
      body: Column(
        children: [
        ],
      ),
    );
  }
}