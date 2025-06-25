import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/pet.dart';

class MyAppState extends ChangeNotifier {
  late Box<Pet> _petBox;

  MyAppState() {
    _petBox = Hive.box('pets');
  }

  List<Pet> get pets => _petBox.values.toList();

  void addPet(Pet pet) async {
    await _petBox.add(pet);
    notifyListeners();
  }

  void deletePet(Pet pet) async {
    await pet.delete();
    notifyListeners();
  }

  void clearAllPets() async {
    await _petBox.clear();
    notifyListeners();
  }
}