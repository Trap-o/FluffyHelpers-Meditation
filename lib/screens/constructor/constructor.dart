import 'package:flutter/material.dart';

import '../../global_widgets/custom_app_bar.dart';

const String _titleText = "Конструктор";

class Constructor extends StatefulWidget {
  const Constructor({super.key});

  @override
  State<Constructor> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
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