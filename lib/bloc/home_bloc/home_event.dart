import 'package:todo/data/models/task_model.dart';

abstract class HomeEvent {}

class HomeEventAbrindoTela extends HomeEvent {}

class HomeEventCriarTask extends HomeEvent {
  final TaskModel task;

  HomeEventCriarTask(this.task);
}