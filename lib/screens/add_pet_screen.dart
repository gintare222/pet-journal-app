import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pet.dart';
import '../state/app_state.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  // ✅ Controllers & state variables
  final _nameController = TextEditingController();
  DateTime? _birthDate;
  String? _selectedGender;

  // Gender options for the dropdown
  final List<String> _genderOptions = ['Male', 'Female', 'Unknown'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Pet')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🐭 Pet Name Input
            _buildNameField(),

            const SizedBox(height: 16),

            // 📅 Birth Date Picker
            _buildDatePicker(),

            const SizedBox(height: 16),

            // ⚧️ Gender Dropdown
            _buildGenderDropdown(),

            const SizedBox(height: 32),

            // 💾 Save Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  /// 🐭 Widget for entering pet name
  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Pet Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  /// 📅 Widget for picking birth date
  Widget _buildDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _birthDate == null
                ? 'Select Birth Date'
                : 'Birth Date: ${_birthDate!.toLocal()}'.split(' ')[0],
          ),
        ),
        ElevatedButton(
          onPressed: _pickDate,
          child: const Text('Pick Date'),
        ),
      ],
    );
  }

  /// Helper to show the date picker dialog
  Future<void> _pickDate() async {
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
  }

  /// ⚧️ Widget for selecting gender
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: _genderOptions.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
    );
  }

  /// 💾 Widget for the save button
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _savePet,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  /// Logic to save pet info
  void _savePet() {
    if (_nameController.text.isEmpty ||
        _birthDate == null ||
        _selectedGender == null) {
      // Optional: show a simple error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final pet = Pet(
      name: _nameController.text,
      birthDate: _birthDate!,
      gender: _selectedGender!,
    );

    Provider.of<MyAppState>(context, listen: false).addPet(pet);

    Navigator.pop(context);
  }
}