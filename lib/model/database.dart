import 'package:drift/drift.dart';
import 'package:export_strat/model/test.dart';
import 'package:export_strat/model/test_dao.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Tests], daos: [TestDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
