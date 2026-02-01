import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  // Internal private list of tasks
  final List<Task> _tasks = [];

  // Getter to access tasks safely from the UI
  List<Task> get tasks => _tasks;

  // Create: Add a new task
  void addTask(String title, {String? emotion}) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      // linkedEmotion: emotion,
    );
    _tasks.insert(0, newTask); // Add to top of the list
    notifyListeners();
  }

  // Update: Toggle completion status
  void toggleTaskStatus(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  // Delete: Remove a task
  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // Helper: Get count of completed tasks (useful for progress bars later)
  int get completedCount => _tasks.where((t) => t.isCompleted).length;
}