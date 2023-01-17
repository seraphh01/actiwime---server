import 'package:actiwime/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditEventWindow extends StatelessWidget {
  late Event event;
  EditEventWindow({Key? key, required this.event}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: event.name);
    descriptionController = TextEditingController(text: event.description);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit event"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: validateEventName,
                        decoration:
                            const InputDecoration(hintText: "Event Name"),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        validator: validateEventName,
                        decoration: const InputDecoration(
                            hintText: "Event Description"),
                      )
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  sendNewEvent(context);
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendNewEvent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      event.name = nameController.value.text;
      event.description = descriptionController.value.text;

      Navigator.of(context).pop(event);
    }
  }

  String? validateEventName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length < 4) {
      return "Input is too short";
    }
    return null;
  }

  void returnEvent(BuildContext context) {
    Navigator.of(context)
        .pop(Event(id: event.id, name: event.name, description: 'hahah'));
  }
}
