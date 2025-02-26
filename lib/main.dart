import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:test_project/ui/home_screen.dart';

import 'data/category.dart';
import 'data/entry.dart';

void main() async {
  // init hive_ce
  await Hive.initFlutter();
  // init Adapters
  Hive.registerAdapter(EntryAdapter());
  Hive.registerAdapter(CategoryAdapter());
  // open a box
  await Hive.openBox("BOX");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
