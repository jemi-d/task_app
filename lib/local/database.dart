
import 'package:drift/drift.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart' as native;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DataClassName('TaskDB')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get urn => text().withDefault(Constant(''))();
  TextColumn get description => text()();
  TextColumn get commencementDate => text()();
  TextColumn get dueDate => text()();
  TextColumn get assignedTo => text()();
  TextColumn get assignedBy => text()();
  TextColumn get clientName => text()();
  TextColumn get status => text().withDefault(Constant('1'))();
  TextColumn get clientDesignation => text()();
  TextColumn get clientEmail => text()();
  TextColumn get currentUserEmail => text()();
  TextColumn get currentUser => text()();
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  // Private constructor
  AppDatabase._internal() : super(_openConnection());

  // Static instance
  static final AppDatabase _instance = AppDatabase._internal();

  // Getter to access the singleton instance
  static AppDatabase get instance => _instance;


  @override
  int get schemaVersion => 1;

  Future<List<TaskDB>> getAllTasks() => select(tasks).get();

  Future<void> insertTask(TasksCompanion task) async {
    await into(tasks).insert(task);
  }

  Future<void> updateTask(TaskDB task) async {
    await update(tasks).replace(task);
  }

  Future<void> deleteTask(int id) async {
    await (delete(tasks)..where((t) => t.id.equals(id))).go();
  }

  Future<int> updateStatus(int id, String value) {
    return (update(tasks)..where((t) => t.id.equals(id)))
        .write(TasksCompanion(status: Value(value)));   // Update status to '0'
  }
  Future<List<TaskDB>> getActiveTasks() => (select(tasks)..where((t) => t.status.equals('1'))).get();

  // Future<List<TaskDB>> getAllDeletedTasks() => (select(tasks)..where((t) => t.status.equals('0'))).get();
  // Future<List<TaskDB>> getAllCompletedTasks() => (select(tasks)..where((t) => t.status.equals('2'))).get();

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite1'));
    return LazyDatabase(() async => native.NativeDatabase(file,logStatements: true));
  });
}
