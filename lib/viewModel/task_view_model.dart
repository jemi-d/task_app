import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../local/database.dart';

class TaskProvider extends ChangeNotifier {
  static final storage = FlutterSecureStorage();
  final AppDatabase _database = AppDatabase.instance;
  List<TaskDB> _tasks = [];
  bool _isLoading = false;

  List<TaskDB> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Get scheduled task - status 1
  Future<void> getScheduledTasks() async {
    String? storedEmail = await storage.read(key: 'email');
    _isLoading = true;
    notifyListeners();
    List<TaskDB> list = await _database.getActiveTasks();
    _tasks = list.where((t)=> t.currentUserEmail == storedEmail).toList(); // Get the list based on the user email
    _isLoading = false;
    notifyListeners();
  }

  // Add task
  Future<void> addTask(TasksCompanion task) async {
    await _database.insertTask(task);
    await getScheduledTasks();
  }

  // Update task
  Future<void> editTask(TaskDB task) async {
    await _database.updateTask(task);
    await getScheduledTasks();
  }

  // Update status
  Future<void> updateStatus(int id, String value,) async {
    await _database.updateStatus(id, value);
    await getScheduledTasks(); // Refresh tasks after deleting
  }

  // Handle task by category
  Future<void> handleTaskCategory(int taskC) async {
    String? storedEmail = await storage.read(key: 'email');

    if(taskC == 0){
      List<TaskDB> list = await _database.getAllTasks();
      List<TaskDB> a = list.where((t)=> t.currentUserEmail == storedEmail).toList();
      _tasks = a.where((t) => t.status == taskC.toString()).toList();
      notifyListeners();
    }else if(taskC == 1){
      List<TaskDB> list = await _database.getAllTasks();
      List<TaskDB> a = list.where((t)=> t.currentUserEmail == storedEmail).toList();
      _tasks = a.where((t) => t.status == taskC.toString()).toList();
      notifyListeners();
    }else if(taskC == 2){
      List<TaskDB> list = await _database.getAllTasks();
      List<TaskDB> a = list.where((t)=> t.currentUserEmail == storedEmail).toList();
      _tasks = a.where((t) => t.status == taskC.toString()).toList();
      notifyListeners();
    }else{
      List<TaskDB> list = await _database.getAllTasks();
      List<TaskDB> a = list.where((t)=> t.currentUserEmail == storedEmail).toList();
      _tasks = a.where((t) => t.status == taskC.toString()).toList();
      notifyListeners();
    }
  }
}