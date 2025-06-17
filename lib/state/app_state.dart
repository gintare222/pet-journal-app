import 'package:flutter/material.dart';
import '../models/pet.dart';

class MyAppState extends ChangeNotifier {
  final List<Pet> pets = [];

  void addPet(Pet pet) {
    pets.add(pet);
    notifyListeners();
  }
}