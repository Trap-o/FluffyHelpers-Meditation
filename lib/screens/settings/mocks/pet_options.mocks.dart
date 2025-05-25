import 'package:fluffyhelpers_meditation/screens/settings/models/pet_option.dart';

final List<PetOption> petOptions = [
  PetOption(key: "cat"),
  PetOption(key: "dog"),
  PetOption(key: "fox"),
];

final Map<String, PetOption> petOptionsMap = {
  for(var pet in petOptions)
    pet.key : pet
};