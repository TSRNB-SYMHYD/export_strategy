import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/native.dart';
import 'package:export_strat/model/database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Sqlite {
  Future<String> exportToCsv(AppDatabase db) async {
    final testDao = db.testDao;
    final tests = await testDao.getAllTests();

    final List<List<dynamic>> rows = [];
    rows.add(["ID", "Name", "Age"]); // Header row
    for (var test in tests) {
      rows.add([test.id, test.name, test.age]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    final directory = await getExternalStorageDirectory();
    final path = '${directory?.path}/test_data.csv';

    final file = File(path);
    await file.writeAsString(csvData);

    return path;
  }

  Future<AppDatabase> openDatabase() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final path = join(dbFolder.path, 'app_database.db');

    final dbFile = File(path);
    if (!(await dbFile.exists())) {
      await dbFile.create(recursive: true);
    }

    return AppDatabase(NativeDatabase(File(path)));
  }
}
