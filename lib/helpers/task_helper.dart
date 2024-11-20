import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/models/task_model.dart';

class TaskHelper {
  static Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final _tasks = prefs.getString('tasks') ?? "";
    if (_tasks.isEmpty) {
      return [];
    }
    final taskJson = json.decode(_tasks) as List;
    final tasksFinal = taskJson.map((task) => TaskModel.fromJson(task as Map<String, dynamic>)).toList();
    return tasksFinal;
  }

  static Future<void> criarTask(TaskModel task) async {
    final _pref = await SharedPreferences.getInstance();
    final _tasks = await getTasks();
    task.id = (_tasks.isEmpty ? 1 : _tasks.last.id! + 1);
    _tasks.add(task);
    await _pref.setString('tasks', json.encode(_tasks));
  }

  static excluirTask(TaskModel task) async {
    final _pref = await SharedPreferences.getInstance();
    final _tasks = await getTasks();
    _tasks.remove(_tasks.firstWhere((element) => element.id == task.id));
    await _pref.setString('tasks', json.encode(_tasks));
  }

  static atualizarTask(TaskModel task) async {
    final _pref = await SharedPreferences.getInstance();
    final _tasks = await getTasks();
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    await _pref.setString('tasks', json.encode(_tasks));
  }
}
