// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TestsTable extends Tests with TableInfo<$TestsTable, Test> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, age];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tests';
  @override
  VerificationContext validateIntegrity(Insertable<Test> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Test map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Test(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
    );
  }

  @override
  $TestsTable createAlias(String alias) {
    return $TestsTable(attachedDatabase, alias);
  }
}

class Test extends DataClass implements Insertable<Test> {
  final int? id;
  final String name;
  final int age;
  const Test({this.id, required this.name, required this.age});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['name'] = Variable<String>(name);
    map['age'] = Variable<int>(age);
    return map;
  }

  TestsCompanion toCompanion(bool nullToAbsent) {
    return TestsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      age: Value(age),
    );
  }

  factory Test.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Test(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int>(json['age']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int>(age),
    };
  }

  Test copyWith(
          {Value<int?> id = const Value.absent(), String? name, int? age}) =>
      Test(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        age: age ?? this.age,
      );
  Test copyWithCompanion(TestsCompanion data) {
    return Test(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Test(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Test &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age);
}

class TestsCompanion extends UpdateCompanion<Test> {
  final Value<int?> id;
  final Value<String> name;
  final Value<int> age;
  const TestsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
  });
  TestsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int age,
  })  : name = Value(name),
        age = Value(age);
  static Insertable<Test> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? age,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
    });
  }

  TestsCompanion copyWith(
      {Value<int?>? id, Value<String>? name, Value<int>? age}) {
    return TestsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TestsTable tests = $TestsTable(this);
  late final TestDao testDao = TestDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tests];
}

typedef $$TestsTableCreateCompanionBuilder = TestsCompanion Function({
  Value<int?> id,
  required String name,
  required int age,
});
typedef $$TestsTableUpdateCompanionBuilder = TestsCompanion Function({
  Value<int?> id,
  Value<String> name,
  Value<int> age,
});

class $$TestsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TestsTable> {
  $$TestsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get age => $state.composableBuilder(
      column: $state.table.age,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TestsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TestsTable> {
  $$TestsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get age => $state.composableBuilder(
      column: $state.table.age,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, BaseReferences<_$AppDatabase, $TestsTable, Test>),
    Test,
    PrefetchHooks Function()> {
  $$TestsTableTableManager(_$AppDatabase db, $TestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TestsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TestsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> age = const Value.absent(),
          }) =>
              TestsCompanion(
            id: id,
            name: name,
            age: age,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            required String name,
            required int age,
          }) =>
              TestsCompanion.insert(
            id: id,
            name: name,
            age: age,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, BaseReferences<_$AppDatabase, $TestsTable, Test>),
    Test,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TestsTableTableManager get tests =>
      $$TestsTableTableManager(_db, _db.tests);
}
