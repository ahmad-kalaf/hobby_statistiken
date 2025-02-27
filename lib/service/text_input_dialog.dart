import 'package:flutter/material.dart';

class TexteingabeDialog {
  static Future<String?> show(BuildContext context, String title) async {
    TextEditingController textController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: "Ihr Text"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
