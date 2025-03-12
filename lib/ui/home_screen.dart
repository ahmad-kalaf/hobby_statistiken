import "package:flutter/material.dart";
import "package:test_project/ui/category_overview_screen.dart";
import "package:test_project/ui/home_overview_screen.dart";
import "package:test_project/ui/search_entries_overview_screen.dart";

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
    SearchEntriesOverviewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentScreenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Startseite",
          ),
          NavigationDestination(
            icon: Icon(Icons.category),
            label: "Kategorien",
          ),
          NavigationDestination(
            icon: Icon(Icons.manage_search_outlined),
            label: "Suche",
          ),
        ],
      ),
    );
  }
}
