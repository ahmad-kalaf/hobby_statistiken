import 'package:hive_ce_flutter/hive_flutter.dart';

part 'entry.g.dart';

@HiveType(typeId: 0)
class Entry {
  // Instances
  @HiveField(0)
  final String? _category;
  @HiveField(1)
  final DateTime _eventDate;
  @HiveField(2)
  final String? _description;

  // Constructor
  Entry(this._category, this._eventDate, this._description);

  @override
  String toString() {
    return "Datum: ${_eventDate.day}.${_eventDate.month}.${_eventDate.year} Kategorie: $_category";
  }

  // getter
  String? get category => _category;

  DateTime get eventDate => _eventDate;

  String? get description => _description;
}
