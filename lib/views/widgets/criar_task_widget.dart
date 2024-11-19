import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CriarTaskWidget extends StatelessWidget {
  const CriarTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _deadlineController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              minLines: 8,
              keyboardType: TextInputType.multiline,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Deadline (optional)",
              border: const OutlineInputBorder(),
              fillColor: Colors.white,
              suffixIcon: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () {
                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2023))
                        .then((value) {
                      _deadlineController = TextEditingController(text: value.toString());
                    });
                  }),
            ),
            keyboardType: TextInputType.datetime,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 10.0),
          SizedBox(child: FilledButton(onPressed: () {}, child: Text("ADD TASK")))
        ],
      ),
    );
  }
}
