import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';

class TaskCardWidget extends StatefulWidget {
  final TaskModel task;

  const TaskCardWidget({super.key, required this.task});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.deadLine != null ? Colors.redAccent : Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            widget.task.deadLine != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.task.title, style: TextStyle(fontSize: 20, color: Colors.white)),
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.task.title, style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Text(
                  widget.task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
