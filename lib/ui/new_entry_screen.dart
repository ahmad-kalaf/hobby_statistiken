import 'package:flutter/material.dart';
import 'package:test_project/service/strings_constants.dart';

import '../data/entry.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final TextEditingController _categoryTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _selectDateButtonText = kDateTimePickerText;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1700),
      lastDate: DateTime(2200),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
      throw Exception(kSelectDateNullExceptionText);
    }
  }

  Entry createEntry() {
    String category = _categoryTextEditingController.text.trim();
    if (category.isEmpty) {
      category = kDefaultCategoryName;
    }
    return Entry(
        category, selectedDate, _descriptionTextEditingController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          kNewEntryScreenTitle,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
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
          DecoratedBox(
            decoration: BoxDecoration(
              // color: Colors.blue, // Hintergrundfarbe
              borderRadius: BorderRadius.circular(20), // Abgerundete Ecken
              border: Border.all(color: Colors.blue, width: 2), // Rand
            ),
            child: ListTile(
              leading: Text(kEntryCategory),
              title: TextField(
                controller: _categoryTextEditingController,
                decoration: InputDecoration(
                  labelText: "Gib deinen Text ein",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),

          DecoratedBox(
            decoration: BoxDecoration(
              // color: Colors.blue, // Hintergrundfarbe
              borderRadius: BorderRadius.circular(20), // Abgerundete Ecken
              border: Border.all(color: Colors.blue, width: 2), // Rand
            ),
            child: ListTile(
              leading: Text(kEntryDescription),
              title: TextField(
                controller: _descriptionTextEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Gib deinen Text ein",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Entry entry = createEntry();
          Navigator.pop(context, entry);
        },
        label: Text(
          kSaveEntry,
        ),
        icon: Icon(Icons.check_circle_outline_rounded),
      ),
    );
  }
}
