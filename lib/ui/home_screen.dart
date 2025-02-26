import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:test_project/service/texteingabe_dialog.dart";
import "package:test_project/ui/new_entry.dart";
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

  void addEntry(Entry val) {
    setState(() {
      _entries.add(val);
    });
    _myBox.put("ENTRIES", _entries);
  }

  void deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
    _myBox.put("ENTRIES", _entries);
  }

  void addCategory(Category category) {
    setState(() {
      _categories.add(category);
    });
    _myBox.put("CATEGORIES", _categories);
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
                  if (result != null && result.isNotEmpty) {
                    addCategory(Category(result));
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
                      Text(
                        style: const TextStyle(fontSize: 24),
                        "Kategorie: ${e.category}",
                      ),
                      Text(
                        style: const TextStyle(fontSize: 24),
                        "Datum:: ${e.eventDate.day}.${e.eventDate.month}.${e.eventDate.year}",
                      ),
                      IconButton(
                        onPressed: () {
                          deleteEntry(index);
                        },
                        icon: Icon(
                          Icons.remove_circle_outline_rounded,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length, // Anzahl der Einträge
              itemBuilder: (context, index) {
                String key = _categories[index].title; // Schlüssel abrufen
                return ListTile(
                  title: Text(
                    key,
                    textAlign: TextAlign.center,
                  ), // Schlüssel als Titel anzeigen
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<Entry>(
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
