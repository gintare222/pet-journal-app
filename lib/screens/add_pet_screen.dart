import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pet.dart';
import '../state/app_state.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _nameController = TextEditingController();
  DateTime? _birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add pet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Pet name'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _birthDate == null ? 'Select birth date' : 'Birth date: ${_birthDate!.toLocal()}'.split(' ')[0]
                    )
                  ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2000), 
                      lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _birthDate = picked;
                        });
                      }
                  }, 
                  child: const Text('Pick date'),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _birthDate != null) {
                  final pet = Pet(
                    name: _nameController.text, 
                    birthDate: _birthDate!,
                  );
                  Provider.of<MyAppState>(context, listen: false).addPet(pet);
                  Navigator.pop(context);
                }
              }, 
              child: const Text('Save'),
              )
          ],
        ),
      ),
    );
  }
}