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

  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: const Text(
      style: TextStyle(
        color: Colors.red,
      ),
      'Beschreibung / Inhalt darf nicht leer sein',
    ),
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          kNewEntryScreenTitle,
        ),
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                await _selectDate();
              },
              child: Text(
                _selectDateButtonText,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListTile(
              // leading: Text(kEntryCategory),
              // titleAlignment: ListTileTitleAlignment.titleHeight,
              title: TextField(
                controller: _categoryTextEditingController,
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: "Kategoriename eingeben",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListTile(
              // leading: Text(kEntryDescription),
              title: TextField(
                controller: _descriptionTextEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 2000,
                decoration: InputDecoration(
                  labelText: "Beschreibung / Inhalt eingeben",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_descriptionTextEditingController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Entry entry = createEntry();
            Navigator.pop(context, entry);
          }
        },
        label: Text(
          kSaveEntry,
        ),
        icon: Icon(Icons.check_circle_outline_rounded),
      ),
    );
  }
}
