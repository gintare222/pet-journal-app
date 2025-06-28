import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'add_pet_screen.dart';
import 'edit_pet_screen.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
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
                'Age: ${pet.ageInYears} years, ${pet.ageInMonths % 12} months, ${pet.ageInDays % 30} days',
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditPetScreen(pet: pet)),
                  );
                  setState(() {});
                },
              ),
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
