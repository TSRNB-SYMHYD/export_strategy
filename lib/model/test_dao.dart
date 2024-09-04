import 'package:drift/drift.dart';
import 'package:export_strat/model/test.dart';
import 'database.dart';

part 'test_dao.g.dart';

@DriftAccessor(tables: [Tests])
class TestDao extends DatabaseAccessor<AppDatabase> with _$TestDaoMixin {
  final AppDatabase db;

  TestDao(this.db) : super(db);

  Future<List<Test>> getAllTests() => select(tests).get();
  Stream<Test?> getTestById(int id) => (select(tests)..where((t) => t.id.equals(id))).watchSingle();
  Future<void> insertTest(Test test) => into(tests).insert(test);
}
