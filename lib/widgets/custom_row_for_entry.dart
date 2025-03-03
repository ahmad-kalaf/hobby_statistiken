import 'package:flutter/material.dart';

class CustomRowForEntry extends StatelessWidget {
  const CustomRowForEntry({
    super.key,
    required this.leading,
    required this.content,
  });

  final String leading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
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
            flex: 1,
            child: Text(
              leading,
              style: TextStyle(fontSize: 18),
            ), // Äquivalent zu "title"
          ),
          SizedBox(width: 10), // Abstand zwischen den Spalten
          Expanded(
            flex: 3,
            child: Text(
              content,
              style: TextStyle(fontSize: 18),
            ), // Äquivalent zu "title"
          ),
        ],
      ),
    );
  }
}
