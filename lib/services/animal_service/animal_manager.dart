import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalManager {
  static final AnimalManager _instance = AnimalManager._internal();

  factory AnimalManager() => _instance;

  AnimalManager._internal();

  final ValueNotifier<String> selectedPet = ValueNotifier<String>('cat');

  String getAnimalName() => selectedPet.value;

  Future<void> setAnimalName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPet = prefs.getString('pet') ?? 'cat';
    selectedPet.value = savedPet;
  }
}




