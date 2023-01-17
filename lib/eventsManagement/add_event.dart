import 'dart:math';

import 'package:actiwime/entities/event.dart';
import 'package:actiwime/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddEventWindow extends StatelessWidget {
  AddEventWindow({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new event"),
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
      var rand = Random().nextInt(1000);
      var event = Event(
          id: rand,
          name: nameController.value.text,
          description: descriptionController.value.text);

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
}
