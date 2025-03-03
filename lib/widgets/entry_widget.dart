import 'package:flutter/material.dart';
import 'package:test_project/service/strings_constants.dart';
import 'package:test_project/widgets/custom_row_for_entry.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget(
      {super.key,
      required this.category,
      required this.date,
      required this.description,
      required this.deleteFunction});

  final String category;
  final String date;
  final String description;
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
          CustomRowForEntry(
            leading: kEntryCategory,
            content: category,
          ),
          CustomRowForEntry(leading: kDate, content: date),
          CustomRowForEntry(leading: kDescription, content: description),
          IconButton(
            onPressed: deleteFunction,
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
