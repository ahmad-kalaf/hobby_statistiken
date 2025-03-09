import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:test_project/service/entry_provider.dart";
import "package:test_project/ui/category_overview_screen.dart";
import "package:test_project/ui/home_overview_screen.dart";
import "package:test_project/ui/new_entry_screen.dart";
import "../data/entry.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // current screen index
  int _currentScreenIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeOverviewScreen(),
    CategoryOverviewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // addEntry(result);
            Provider.of<EntryProvider>(context, listen: false).addEntry(result);
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
