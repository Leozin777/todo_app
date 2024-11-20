import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/home_bloc/home_state.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/views/widgets/titulo_home_widget.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/home_bloc/home_event.dart';
import '../widgets/manipular_task_widget.dart';
import '../widgets/task_card_widget.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<TaskModel> _tasks;

  @override
  void initState() {
    _tasks = [];
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEventAbrindoTela());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeStateTaskBuscadaComSucesso) {
          setState(() {
            _tasks = state.tasks;
          });
        } else if (state is HomeStateOpenLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeStateCloseLoading) {
          Navigator.pop(context);
        } else if (state is HomeStateOpenError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
            ),
          );
        } else if (state is HomeStateTaskCriadaComSucesso) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Task created successfully"),
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "TO DO LIST",
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TituloHomeWidget(),
                  const SizedBox(height: 20),
                  _tasks.isEmpty
                      ? const Center(
                          child: Text(
                            "No tasks found",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (_) => EditTaskScreen(
                                        task: _tasks[index],
                                      ),
                                    ),
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      BlocProvider.of<HomeBloc>(context).add(HomeEventAbrindoTela());
                                    }
                                  });
                                },
                                child: TaskCardWidget(
                                  task: _tasks[index],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () async {
                final task = await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context2, StateSetter setModalState) {
                        return ManipularTaskWidget(
                          setModalState: setModalState,
                        );
                      });
                    });

                if (task != null) {
                  BlocProvider.of<HomeBloc>(context).add(
                    HomeEventCriarTask(
                      task as TaskModel,
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
