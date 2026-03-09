import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final _myBox = Hive.box('tasksBox');
  List<dynamic> _tasks = [];

  List<dynamic> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  // Load tasks from Hive on startup
  void loadTasks() {
    _tasks = _myBox.get("TASK_LIST") ?? [];
    notifyListeners();
  }

  // Save/Update Task
  void addTask(String title) {
    // We store as a Map for simplicity in a quick project
    _tasks.add({
      "title": title,
      "isCompleted": false,
    });
    _updateDatabase();
  }

  void toggleTaskStatus(int index) {
    _tasks[index]["isCompleted"] = !_tasks[index]["isCompleted"];
    _updateDatabase();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _updateDatabase();
  }

  // The core Hive save function
  void _updateDatabase() {
    _myBox.put("TASK_LIST", _tasks);
    notifyListeners();
  }
}
