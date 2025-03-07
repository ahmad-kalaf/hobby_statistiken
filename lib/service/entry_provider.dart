import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import '../data/category.dart';
import '../data/entry.dart';

class EntryProvider extends ChangeNotifier {
  final _myBox = Hive.box("BOX");

  List<Entry> _entries = [];
  List<Category> _categories = [];

  UnmodifiableListView<Entry> get entries => UnmodifiableListView(_entries);

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  EntryProvider() {
    loadData();
  }

  void loadData() {
    _entries = (_myBox.get("ENTRIES") as List?)?.cast<Entry>() ?? [];
    _categories = (_myBox.get("CATEGORIES") as List?)?.cast<Category>() ?? [];
    notifyListeners();
  }

  void addEntry(Entry val) {
    _entries.add(val);

    if (val.category != null) {
      if (!_categories.any((element) => element.title == val.category)) {
        Category category = Category.stringToCategory(val.category!);
        category.numOfEntries++;
        _categories.add(category);
      } else {
        _categories
            .firstWhere((element) => element.title == val.category)
            .numOfEntries++;
      }
    }

    _myBox.put("ENTRIES", _entries);
    _myBox.put("CATEGORIES", _categories);

    notifyListeners();
  }

  void deleteEntry(int index) {
    if (index < 0 || index >= _entries.length) return;

    _entries.removeAt(index);
    _myBox.put("ENTRIES", _entries);

    notifyListeners();
  }
}
