import 'package:flutter/material.dart';

import '../data/entry.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  DateTime selectedDate = DateTime.now();
  String _selectDateButtonText = "Datum auswählen";

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1700),
      lastDate: DateTime(2200),
    );

    if (pickedDate != null) {
      setState(
        () {
          selectedDate = pickedDate;
          _selectDateButtonText =
              "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
        },
      );
    } else {
      throw Exception("selectedDate is null");
    }
  }

  Entry createEntry() {
    return Entry("Testkategorie", selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Neuen Eintrag erstellen",
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Empty row to expand column in horizontal direction
          const Row(mainAxisSize: MainAxisSize.max),
          ElevatedButton(
            onPressed: () async {
              await _selectDate();
            },
            child: Text(
              _selectDateButtonText,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Entry entry = createEntry();
          Navigator.pop(context, entry);
        },
        child: Text(
          "Speichern",
        ),
      ),
    );
  }
}
