import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:test_project/ui/month.dart';

import '../data/entry.dart';

class OverviewMonth extends StatefulWidget {
  const OverviewMonth({super.key, required this.months});

  final List<Month> months;

  @override
  State<OverviewMonth> createState() => _OverviewMonthState();
}

class _OverviewMonthState extends State<OverviewMonth> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.months.length,
      itemBuilder: (context, index) {
        return widget.months[index];
      },
    );
  }
}
