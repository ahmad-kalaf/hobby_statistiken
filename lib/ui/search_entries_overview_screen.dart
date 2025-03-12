import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project/service/entry_provider.dart';
import 'package:test_project/widgets/entry_widget.dart';

import '../data/entry.dart';
import '../service/strings_constants.dart';

class SearchEntriesOverviewScreen extends StatefulWidget {
  const SearchEntriesOverviewScreen({super.key});

  @override
  State<SearchEntriesOverviewScreen> createState() =>
      _SearchEntriesOverviewScreenState();
}

class _SearchEntriesOverviewScreenState
    extends State<SearchEntriesOverviewScreen> {
  DateTime selectedDate = DateTime.now();
  String _selectDateButtonText = kDateTimePickerText;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1700),
      lastDate: DateTime(2200),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );

    if (pickedDate != null) {
      setState(
        () {
          selectedDate = pickedDate;
          _selectDateButtonText =
              "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suchen'),
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                await _selectDate();
              },
              child: Text(
                _selectDateButtonText,
              ),
            ),
          ),
          Expanded(
            child: Consumer<EntryProvider>(
              builder: (context, provider, child) {
                List<Entry> entries = provider.getEntriesForDate(selectedDate);
                if (entries.isEmpty) {
                  return Center(
                    child: Text(
                        'Keine Einträge für das ausgewählte Datum gefunden.'),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.entries.length,
                        itemBuilder: (context, index) {
                          Entry e = entries[index];
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
            ),
          )
        ],
      ),
    );
  }
}
