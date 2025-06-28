import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/pet.dart';

class EditPetScreen extends StatefulWidget {
  final Pet pet;

  const EditPetScreen({super.key, required this.pet});

  @override
  State<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  late TextEditingController _nameController;
  late DateTime _selectedDate;
  late String _selectedGender;

  final List<String> _genders = ['Male', 'Female', 'Unknown'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _selectedDate = widget.pet.birthDate;
    _selectedGender = widget.pet.gender;
  }

  void _saveChanges() {
    setState(() {
      widget.pet.name = _nameController.text;
      widget.pet.birthDate = _selectedDate;
      widget.pet.gender = _selectedGender;
      widget.pet.save(); // Updates in Hive
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pet updated successfully!')));

    Navigator.pop(context);
  }

  void _deletePet() {
    widget.pet.delete(); // Deletes from Hive

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pet deleted')));

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: _deletePet,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Birth date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                ),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: _pickDate,
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              items:
                  _genders.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedGender = value;
                  });
                }
              },
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
