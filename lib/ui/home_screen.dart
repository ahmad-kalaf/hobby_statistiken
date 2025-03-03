import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:intl/intl.dart";
import "package:test_project/ui/category_overview_screen.dart";
import "package:test_project/ui/home_overview_screen.dart";
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

  // current screen index
  int _currentScreenIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeOverviewScreen(),
    CategoryOverviewScreen(),
  ];

  final List<String> _screensTitles = [
    "Startseite",
    "Kategorienansicht",
  ];

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
        title: Text(
          _screensTitles[_currentScreenIndex],
        ),
      ),
      body: _screens[_currentScreenIndex],
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentScreenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Startseite"),
          NavigationDestination(
              icon: Icon(Icons.category), label: "Kategorien"),
        ],
      ),
    );
  }
}
