import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart';

import '../data/category.dart';
import '../data/entry.dart';
import '../widgets/entry_widget.dart';

class HomeOverviewScreen extends StatefulWidget {
  const HomeOverviewScreen({super.key});

  @override
  State<HomeOverviewScreen> createState() => _HomeOverviewScreenState();
}

class _HomeOverviewScreenState extends State<HomeOverviewScreen> {
  // get the box
  final _myBox = Hive.box("BOX");

  // entries, each entry belongs to zero or more categories
  List<Entry> _entries = [];

  // Categories, each category has zero or more entries
  List<Category> _categories = [];

  @override
  void initState() {
    _entries = (_myBox.get("ENTRIES") as List?)?.cast<Entry>() ?? [];
    _categories = (_myBox.get("CATEGORIES") as List?)?.cast<Category>() ?? [];
    super.initState();
  }

  void countEntriesForEachCategory() {
    for (Category category in _categories) {
      category.numOfEntries =
          _entries.where((e) => e.category == category.title).length;
    }
  }

  void updateCategoriesAndEntries() {
    setState(() {
      _myBox.put("ENTRIES", _entries);
      _myBox.put("CATEGORIES", _categories);
    });
  }

  void deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
    countEntriesForEachCategory();
    updateCategoriesAndEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _entries.length,
            itemBuilder: (context, index) {
              Entry e = _entries[index];
              return EntryWidget(
                category: e.category.toString(),
                date: DateFormat('EEE , d/M/y', 'de_DE').format(e.eventDate),
                description: e.description.toString(),
                deleteFunction: () {
                  deleteEntry(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
