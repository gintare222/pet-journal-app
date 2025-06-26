import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'add_pet_screen.dart';

class PetListScreen extends StatelessWidget {
  const PetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = context.watch<MyAppState>().pets;

    return Scaffold(
      appBar: AppBar(title: const Text('Your pets')),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            child: ListTile(
              title: Text(pet.name),
              subtitle: Text(
                'Born: ${pet.birthDate.toLocal().toString().split(' ')[0]}\n'
                'Gender: ${pet.gender}\n'
                'Age: ${pet.ageInYears} years, ${pet.ageInMonths % 12} months, ${pet.ageInDays % 30} days'
              ),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetScreen()),
          );
        },
      ),
    );
  }
}
