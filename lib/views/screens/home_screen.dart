import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/views/widgets/titulo_home_widget.dart';

import '../widgets/criar_task_widget.dart';
import '../widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel>? _tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TO DO LIST",
                    style: TextStyle(fontSize: 20, color: Colors.redAccent),
                  ),
                  Icon(Icons.settings, color: Colors.redAccent),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TituloHomeWidget(),
                  GestureDetector(child: const Icon(Icons.filter_alt_outlined, color: Colors.redAccent)),
                ],
              ),
              const SizedBox(height: 20),
              _tasks != null
                  ? ListView(
                      children: _tasks!
                          .map((e) => TaskCardWidget(title: e.title, description: e.description, isDeadLine: e.deadLine != null))
                          .toList(),
                    )
                  : const Center(child: Text("empty list")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showModalBottomSheet(isScrollControlled: true ,context: context, builder: (_) => const CriarTaskWidget());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
