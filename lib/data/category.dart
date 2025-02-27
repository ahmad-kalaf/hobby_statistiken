import 'package:hive_ce_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String title;
  @HiveField(1)
  int numOfEntries;

  Category(this.title, {this.numOfEntries = 0});

  static Category stringToCategory(String s) {
    if (s.isEmpty) {
      throw Exception("String s darf nicht null sein");
    }
    return Category(s);
  }
}
