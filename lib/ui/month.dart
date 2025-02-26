import 'package:flutter/material.dart';

class Month extends StatelessWidget {
  final String name;
  final int entriesCount;

  const Month({super.key, required this.name, required this.entriesCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10), // Äußerer Abstand
        padding: const EdgeInsets.all(10), // Innerer Abstand
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue, // Farbe des Rahmens
            width: 2, // Breite des Rahmens
          ),
        ),
        child: Column(
          children: [
            Text(
              style: const TextStyle(fontSize: 40),
              name,
            ),
            Text(
              "Anzahl Einträge: $entriesCount",
            ),
          ],
        ),
      ),
    );
  }
}
