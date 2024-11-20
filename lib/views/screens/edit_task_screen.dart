import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/helpers/task_helper.dart';

import '../widgets/manipular_task_widget.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TaskModel _taskEdit;
  bool _deadLineVisible = false;

  @override
  void initState() {
    _taskEdit = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _deadLineVisible = !_deadLineVisible;
                });
              },
              icon: _taskEdit.deadLine == null
                  ? Icon(Icons.history, color: Colors.grey)
                  : Badge(
                      isLabelVisible: _deadLineVisible,
                      offset: const Offset(0, 0),
                      alignment: Alignment.bottomLeft,
                      backgroundColor: Colors.red,
                      label: Text(
                        DateFormat.yMMMMd().format(widget.task.deadLine!),
                      ),
                      child: Icon(
                        (Icons.history),
                      ),
                    )),
          IconButton(
              onPressed: () async {
                final task = await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context2, StateSetter setModalState) {
                        return ManipularTaskWidget(
                          task: _taskEdit,
                          setModalState: setModalState,
                        );
                      });
                    });

                if (task != null) {
                  task.id = widget.task.id;
                  await TaskHelper.atualizarTask(task);

                  setState(() {
                    _taskEdit = task;
                  });
                }
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                _taskEdit.id = widget.task.id;
                await TaskHelper.excluirTask(_taskEdit);
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(_taskEdit.title, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Align(alignment: Alignment.topLeft, child: Text(widget.task.description)),
          ],
        ),
      ),
    );
  }
}
