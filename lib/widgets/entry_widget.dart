import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/service/strings_constants.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget(
      {super.key,
      required this.category,
      required this.date,
      required this.description,
      required this.deleteFunction});

  final String category;
  final String date;
  final String description;
  final VoidCallback deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '$kEntryCategory: $category',
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      deleteFunction();
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_forever),
                            Text('Löschen'),
                          ],
                        ),
                      ),
                    ];
                  },
                  icon: Icon(
                    Icons.more_vert,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
          SelectableRegion(
            selectionControls: defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.macOS
                ? CupertinoTextSelectionControls()
                : (defaultTargetPlatform == TargetPlatform.android
                    ? MaterialTextSelectionControls()
                    : DesktopTextSelectionControls()),
            child: Text(
              description,
              style: TextStyle(fontSize: 18),
              maxLines: 3, // Maximal 5 Zeilen
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
