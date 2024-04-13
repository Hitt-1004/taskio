import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/taskModel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? taskStrings = prefs.getStringList('tasks');
      if (taskStrings != null) {
        _tasks = taskStrings.map((taskString) {
          Map<String, dynamic> taskMap = Map<String, dynamic>.from(json.decode(taskString));
          return Task.fromMap(taskMap);
        }).toList();
        notifyListeners();
      }
    } catch (error) {
      print("Error loading tasks: $error");
    }
  }

  Future<void> _saveTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> taskStrings = _tasks.map((task) => json.encode(task.toMap())).toList();
      await prefs.setStringList('tasks', taskStrings);
    } catch (error) {
      print("Error saving tasks: $error");
    }
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<bool> removeTask(Task task) async {
    try {
      _tasks.remove(task);
      await _saveTasks();
      notifyListeners();
      print("task deleted");
      return true;
    } catch(err) {
      print("Unable to remove task: $err");
      return false;
    }
  }

  Future<void> editTask(Task oldTask, Task newTask) async {
    print(oldTask.subtasks);
    print(newTask.subtasks);
    final index = _tasks.indexWhere((task) => task == oldTask);
    if (index != -1) {
      _tasks[index] = newTask;
      await _saveTasks();
      notifyListeners();
    }
  }
}