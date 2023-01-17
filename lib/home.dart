import 'package:actiwime/edit_event.dart';
import 'package:actiwime/entities/event.dart';
import 'package:actiwime/eventsManagement/delete_event_dialog.dart';
import 'package:actiwime/eventsManagement/event_card.dart';
import 'package:actiwime/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late List<Event> events;

  HomePage({Key? key, required this.events}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.edit),
                    ),
                    alignment: Alignment.centerLeft),
                secondaryBackground: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.delete),
                    ),
                    alignment: Alignment.centerRight),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    editEvent(context, widget.events[index]);
                    return false;
                  } else {
                    return onConfirmDismiss(context, widget.events[index].id);
                  }
                },
                key: UniqueKey(),
                child: EventCard(event: widget.events[index]),
              );
            }));
  }

  Future<bool> onConfirmDismiss(BuildContext context, int eventId) async {
    var delete = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const DeleteEventDialog();
        });

    if (delete != null && delete) {
      await database.eventDao.deleteEvent(eventId);
    }

    return delete ?? false;
  }

  void editEvent(BuildContext context, Event event) async {
    var updated = await Navigator.of(context)
        .push<Event>(MaterialPageRoute(builder: (context) {
      return EditEventWindow(
        event: event,
      );
    }));

    if (updated == null) return;

    var oldEvent =
        widget.events.firstWhere((element) => element.id == updated.id);
    oldEvent.name = updated.name;
    oldEvent.description = updated.description;

    database.eventDao.updateEvent(updated);

    setState(() {});
  }
}
