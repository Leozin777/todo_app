import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/models/task_model.dart';

class TaskHelper {
  static Future<List<TaskModel>> getTasks() async {
    final _pref = await SharedPreferencesAsync();
    final _tasks = await _pref.getString('tasks');
    if (_tasks != null) {
      throw Exception('Nenhuma tarefa foi encontrada');
    } else {
      final tasksDecoded = json.decode(_tasks!);
      return tasksDecoded.map((e) => TaskModel.fromJson(e)).toList();
    }
  }

  static criarTask(TaskModel task) async {
    final _pref = await SharedPreferencesAsync();
    final _tasks = await getTasks();
    _tasks.length == 0 ? task.id = 1 : task.id = _tasks.last.id! + 1;
    _tasks.add(task);
    await _pref.setString('tasks', json.encode(_tasks));
  }

  static excluirTask(TaskModel task) async{
    final _pref = await SharedPreferencesAsync();
    final _tasks = await getTasks();
    _tasks.remove(task);
    await _pref.setString('tasks', json.encode(_tasks));
  }

  static atualizarTask(TaskModel task) async{
    final _pref = await SharedPreferencesAsync();
    final _tasks = await getTasks();
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    await _pref.setString('tasks', json.encode(_tasks));
  }

}
