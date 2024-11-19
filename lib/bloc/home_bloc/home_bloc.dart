import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/helpers/task_helper.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventAbrindoTela>((event, emit) async{
      emit(HomeStateOpenLoading());
      try {
        final tasks = await TaskHelper.getTasks();
        emit(HomeStateCloseLoading());
        emit(HomeStateTaskBuscadaComSucesso(tasks));
      } catch (e) {
        emit(HomeStateCloseLoading());
        emit(HomeStateOpenError(e.toString()));
      }
    });

    on<HomeEventCriarTask>((event, emit) async {
      emit(HomeStateOpenLoading());
      TaskHelper.criarTask(event.task);
      emit(HomeStateCloseLoading());
      emit(HomeStateTaskCriadaComSucesso());
    });
  }
}
