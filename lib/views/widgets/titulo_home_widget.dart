import 'package:flutter/material.dart';

class TituloHomeWidget extends StatelessWidget {
  const TituloHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.checklist, color: Colors.redAccent, size: 40),
        const SizedBox(width: 5),
        Text("LIST OF TASKS", style: TextStyle(fontSize: 25, color: Colors.red)),
      ],
    );
  }
}
