import 'package:flutter/material.dart';

class OverviewCategory extends StatelessWidget {
  const OverviewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Übersicht nach Kategorien",
        ),
      ),
    );
  }
}
