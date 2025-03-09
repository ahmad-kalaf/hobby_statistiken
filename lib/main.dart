import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:test_project/main_theme_data.dart';
import 'package:test_project/service/entry_provider.dart';
import 'package:test_project/ui/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/category.dart';
import 'data/entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE', null);
  // init hive_ce
  await Hive.initFlutter();
  // init Adapters
  Hive.registerAdapter(EntryAdapter());
  Hive.registerAdapter(CategoryAdapter());
  // open a box
  await Hive.openBox("BOX");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EntryProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainThemeData.themeData,
      locale: Locale('de', 'DE'),
      // Sprache auf Deutsch setzen
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'), // Unterstützte Sprachen
      ],
      home: HomeScreen(),
    );
  }
}
