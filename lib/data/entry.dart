import 'package:hive_ce_flutter/hive_flutter.dart';

part 'entry.g.dart';

@HiveType(typeId: 0)
class Entry {
  // Instances
  @HiveField(0)
  final String _category;
  @HiveField(1)
  final DateTime _eventDate;
  late final String _monthName;
  List<String> months = [
    "Januar",
    "Februar",
    "März",
    "April",
    "Mai",
    "Juni",
    "Juli",
    "August",
    "September",
    "Oktober",
    "November",
    "Dezember",
  ];

  // Constructor
  Entry(this._category, this._eventDate) {
    int month = _eventDate.month;
    _monthName = months[month + 1];
  }

  @override
  String toString() {
    return "Datum: ${_eventDate.day}.${_eventDate.month}.${_eventDate.year} Kategorie: $_category";
  }

  // getter
  String get category => _category;

  DateTime get eventDate => _eventDate;

  String get monthName => _monthName;
}
