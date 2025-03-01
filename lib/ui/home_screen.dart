import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:intl/intl.dart";
import "package:test_project/service/text_input_dialog.dart";
import "package:test_project/ui/new_entry_screen.dart";
import "package:test_project/widgets/entry_widget.dart";
import "../data/category.dart";
import "../data/entry.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void updateCategoriesAndEntries() {
    setState(() {
      _myBox.put("ENTRIES", _entries);
      _myBox.put("CATEGORIES", _categories);
    });
  }

  void addEntry(Entry val) {
    setState(() {
      // add entry to entries list
      _entries.add(val);
      // check if the category already exists and update it
      if (val.category != null) {
        if (!_categories.any((element) => element.title == val.category)) {
          // if there is no such category -> create new category
          Category category = Category.stringToCategory(val.category as String);
          category.numOfEntries++;
          _categories.add(category);
        } else {
          // update existing category
          Category existingCategory = _categories.firstWhere(
            (element) => element.title == val.category,
          );
          existingCategory.numOfEntries++;
        }
      }
      // update the number of entries for the category
      countEntriesForEachCategory();
    });
    updateCategoriesAndEntries();
  }

  void deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
    countEntriesForEachCategory();
    updateCategoriesAndEntries();
  }

  void addCategory(Category category) {
    if (_entries.any(
      (element) => element.category == category.title,
    )) {
      return;
    }
    setState(() {
      _categories.add(category);
    });
    updateCategoriesAndEntries();
  }

  void deleteCategoryAt(int index) {
    Category category = _categories.elementAt(index);
    if (_entries.any(
      (element) => element.category == category.title,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Kategorie ist nicht leer. Nur eine leere Kategorie darf gelöscht werden",
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    setState(() {
      // set all elements categories to null
      for (Entry element in _entries) {
        element.category == null;
      }
      _categories.removeAt(index);
    });
    updateCategoriesAndEntries();
  }

  void countEntriesForEachCategory() {
    for (Category category in _categories) {
      category.numOfEntries =
          _entries.where((e) => e.category == category.title).length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Startseite",
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () async {
                  final String? result = await TexteingabeDialog.show(
                      context, "Kategoriename eingeben:");
                  if (result != null &&
                      result.isNotEmpty &&
                      !_categories
                          .contains(Category.stringToCategory(result.trim()))) {
                    addCategory(Category(result.trim()));
                  }
                },
                child: Text(
                  "Kategorie hinzufügen",
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
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
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      deleteCategoryAt(index);
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                    ),
                  ),
                  title: Text(
                    _categories[index].title,
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text("${_categories[index].numOfEntries}"),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final Entry? result = await Navigator.push<Entry>(
            context,
            MaterialPageRoute(
              builder: (context) => const NewEntry(),
            ),
          );
          if (result != null) {
            addEntry(result);
          }
        },
        label: const Text(
          "Neuer Eintrag",
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
