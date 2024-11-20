import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/task_model.dart';

class ManipularTaskWidget extends StatefulWidget {
  final TaskModel? task;
  final StateSetter setModalState;

  const ManipularTaskWidget({super.key, required this.setModalState, this.task});

  @override
  State<ManipularTaskWidget> createState() => _ManipularTaskWidgetState();
}

class _ManipularTaskWidgetState extends State<ManipularTaskWidget> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _deadline;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _deadline = widget.task!.deadLine;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.idle && notification.metrics.atEdge && notification.metrics.pixels == 0) {
          Navigator.pop(context);
          return true;
        }
        return false;
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Title", border: OutlineInputBorder(), fillColor: Colors.white),
                controller: _titleController,
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: "Description", border: OutlineInputBorder(), fillColor: Colors.white),
                  maxLines: null,
                  minLines: 20,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final data = await showDatePicker(
                      context: context,
                      initialDate: _deadline ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );

                    if (data != null) {
                      widget.setModalState(() {
                        _deadline = data;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _deadline == null ? "Deadline (optional)" : DateFormat.yMMMMd().format(_deadline!),
                      ),
                      const Icon(Icons.date_range)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pop(
                      TaskModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                        deadLine: _deadline,
                        createdAt: DateTime.now(),
                      ),
                    );
                  },
                  child: Text(widget.task == null ? "ADD TASK" : "EDIT TASK"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
