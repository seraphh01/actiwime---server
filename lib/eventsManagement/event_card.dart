import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../entities/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
          elevation: 10,
          color: Theme.of(context).cardTheme.color,
          surfaceTintColor: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(event.name),
                    SizedBox(
                      height: 10,
                    ),
                    Text(event.description)
                  ],
                )
              ],
            ),
          )),
    );
  }
}
