import 'package:flutter/material.dart';
import 'package:test_project/service/strings_constants.dart';

class EntryWidget extends StatelessWidget {
  EntryWidget(
      {super.key,
      required this.category,
      required this.date,
      required this.description,
      required this.deleteFunction});

  String category;
  String date;
  String description;
  final VoidCallback deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ListTile(
          //   leading: Text(kEntryCategory),
          //   title: Text(category),
          // ),
          Text(
            style: const TextStyle(fontSize: 24),
            "$kEntryCategory: $category",
          ),
          Text(
            style: const TextStyle(fontSize: 24),
            "$kDate: $date",
          ),
          Text(
            style: const TextStyle(fontSize: 24),
            "$kDescription: $description",
          ),
          IconButton(
            onPressed: deleteFunction,
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
