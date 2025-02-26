import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:test_project/ui/month.dart";
import "package:test_project/ui/new_entry.dart";
import 'package:intl/intl.dart';
import "../data/entry.dart";
import "overview_month.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // get the box
  final _myBox = Hive.box("BOX");

  List entries = [];

  @override
  void initState() {
    entries = _myBox.get("ENTRIES") ?? [];
    _months = [
      Month(name: "Januar", entriesCount: monatsStatistik["Januar"] ?? 0),
      Month(name: "Februar", entriesCount: monatsStatistik["Februar"] ?? 0),
      Month(name: "März", entriesCount: monatsStatistik["März"] ?? 0),
      Month(name: "April", entriesCount: monatsStatistik["April"] ?? 0),
      Month(name: "Mai", entriesCount: monatsStatistik["Mai"] ?? 0),
      Month(name: "Juni", entriesCount: monatsStatistik["Juni"] ?? 0),
      Month(name: "Juli", entriesCount: monatsStatistik["Juli"] ?? 0),
      Month(name: "August", entriesCount: monatsStatistik["August"] ?? 0),
      Month(name: "September", entriesCount: monatsStatistik["September"] ?? 0),
      Month(name: "Oktober", entriesCount: monatsStatistik["Oktober"] ?? 0),
      Month(name: "November", entriesCount: monatsStatistik["November"] ?? 0),
      Month(name: "Dezember", entriesCount: monatsStatistik["Dezember"] ?? 0),
    ];
    super.initState();
  }

  void addEntry(Entry val) {
    String monthKey = val.monthName;
    setState(() {
      entries.add(val);
      monatsStatistik[monthKey] = (monatsStatistik[monthKey] ?? 0) + 1;
    });
    saveEntriesToDB();
  }

  void deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
    saveEntriesToDB();
  }

  void saveEntriesToDB() {
    _myBox.put("ENTRIES", entries);
  }

  // month overview
  // Speichert die Anzahl der Einträge pro Monat
  Map<String, int> monatsStatistik = {};

  late List<Month> _months;

  void te() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Startseite",
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height / 3),
            child: OverviewMonth(
              months: _months,
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 3),
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    entries[index].toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteEntry(index);
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                    ),
                  ),
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
