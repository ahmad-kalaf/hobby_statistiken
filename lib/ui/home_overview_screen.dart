import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/entry.dart';
import '../widgets/entry_widget.dart';
import '../service/entry_provider.dart';

class HomeOverviewScreen extends StatefulWidget {
  const HomeOverviewScreen({super.key});

  @override
  State<HomeOverviewScreen> createState() => _HomeOverviewScreenState();
}

class _HomeOverviewScreenState extends State<HomeOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startseite'),
      ),
      body: Builder(builder: (context) {
        return Consumer<EntryProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.entries.length,
                    itemBuilder: (context, index) {
                      Entry e = provider.entries[index];
                      return EntryWidget(
                        category: e.category.toString(),
                        date: DateFormat('EEE , d/M/y', 'de_DE')
                            .format(e.eventDate),
                        description: e.description.toString(),
                        deleteFunction: () {
                          provider.deleteEntry(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
