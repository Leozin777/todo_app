import 'package:flutter/material.dart';

class TaskCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool isDeadLine;

  const TaskCardWidget({super.key, required this.title, required this.description, required this.isDeadLine});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.isDeadLine ? Colors.redAccent : Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            widget.isDeadLine
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title, style: TextStyle(fontSize: 20, color: Colors.white)),
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.title, style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Text(
                  widget.description,
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
