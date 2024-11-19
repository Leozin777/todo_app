import '../../data/models/task_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeStateOpenLoading extends HomeState {}

class HomeStateCloseLoading extends HomeState {}

class HomeStateOpenError extends HomeState {
  final String message;

  HomeStateOpenError(this.message);
}

class HomeStateTaskCriadaComSucesso extends HomeState {}

class HomeStateTaskBuscadaComSucesso extends HomeState {
  final List<TaskModel> tasks;

  HomeStateTaskBuscadaComSucesso(this.tasks);
}
