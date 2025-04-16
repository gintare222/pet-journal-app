import 'package:flutter/material.dart';

void main() 
{
  runApp(PetJournalApp());
}

class PetJournalApp extends StatelessWidget 
{
  const PetJournalApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My Pet Birthday Tracker')),
        body: const Center(
          child: Text('Hello, Pets! 🐭', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}