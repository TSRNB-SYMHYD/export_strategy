import 'package:drift/drift.dart';

@DataClassName('Test')
class Tests extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get age => integer()();
}
