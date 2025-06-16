import 'package:fluffyhelpers_meditation/screens/settings/models/pet_option.dart';

final List<PetOption> petOptions = [
  PetOption(key: "cat"),
  PetOption(key: "dog"),
  PetOption(key: "fox"),
  PetOption(key: 'bunny'),
  PetOption(key: 'mouse'),
  PetOption(key: 'tiger'),
  PetOption(key: 'red_panda'),
  PetOption(key: 'raccoon')
];

final Map<String, PetOption> petOptionsMap = {
  for (var pet in petOptions) pet.key: pet
};
