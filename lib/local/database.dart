
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
  TextColumn get status => text().withDefault(Constant('Scheduled'))();
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

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<List<TaskDB>> getAllTasks() => select(tasks).get();

  Future<bool> updateTask(TaskDB task) => update(tasks).replace(task);

  Future<int> deleteTask(int id) => (delete(tasks)..where((t) => t.id.equals(id))).go();
}

// QueryExecutor _openConnection() {
//   if (kIsWeb) {
//     return WebDatabase('app_database');
//   } else {
//     return LazyDatabase(() async {
//       final dbFolder = await getApplicationDocumentsDirectory();
//       final file = File(p.join(dbFolder.path, 'app.db'));
//       return native.NativeDatabase.createInBackground(file);
//     });
//   }
// }
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return native.NativeDatabase(file);
  });
}
