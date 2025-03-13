import 'package:flutter/cupertino.dart';
import '../local/database.dart';

class TaskProvider extends ChangeNotifier {
  final AppDatabase _database = AppDatabase.instance;
  List<TaskDB> _tasks = [];

  List<TaskDB> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _database.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(TasksCompanion task) async {
    await _database.insertTask(task);
    fetchTasks();
  }

  Future<void> editTask(TaskDB task) async {
    await _database.updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _database.deleteTask(id);
    fetchTasks();
  }
}