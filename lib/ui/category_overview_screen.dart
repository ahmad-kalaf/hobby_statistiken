import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/category.dart';
import 'package:test_project/service/entry_provider.dart';

import '../data/entry.dart';
import '../widgets/entry_widget.dart';

class CategoryOverviewScreen extends StatefulWidget {
  const CategoryOverviewScreen({super.key});

  @override
  State<CategoryOverviewScreen> createState() => _CategoryOverviewScreenState();
}

class _CategoryOverviewScreenState extends State<CategoryOverviewScreen> {
  String? _selectedCategory;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          _categories = Provider.of<EntryProvider>(context, listen: false)
              .categories
              .toList();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategorienansicht'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            isExpanded: true,
            alignment: Alignment.center,
            hint: Text(
              _categories.isEmpty
                  ? 'Keine Kategorien vorhanden'
                  : 'Kategorie wählen',
            ),
            value: _selectedCategory,
            items: [
              for (int i = 0; i < _categories.length; i++)
                DropdownMenuItem<String>(
                  value: _categories[i].title,
                  alignment: Alignment.center,
                  child: Text(_categories[i].title.toString()),
                ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return Consumer<EntryProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider
                                .getEntriesForCategory(
                                    _selectedCategory.toString())
                                .length,
                            itemBuilder: (context, index) {
                              Entry e = provider.getEntriesForCategory(
                                  _selectedCategory.toString())[index];
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
              },
            ),
          )
        ],
      ),
    );
  }
}
