import 'dart:async';

import 'package:actiwime/entities/event.dart';
import 'package:actiwime/eventsManagement/add_event.dart';
import 'package:actiwime/home.dart';
import 'package:actiwime/main.dart';
import 'package:actiwime/profile.dart';
import 'package:actiwime/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int index = 0;
  late List<Event>? events;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.notes),
        //   onPressed: () {},
        // ),
        title: const Text("Actiwime"),
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(onPressed: addEvent, icon: const Icon(Icons.add)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Nearby Events"),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "My Events",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "My Profile"),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
      ),
      body: IndexedStack(
        index: index,
        children: [SearchPage(), buildEventsList(), ProfilePage()],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addEvent, child: const Icon(Icons.add)),
    );
  }

  void addEvent() async {
    Event? event = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddEventWindow()));

    if (event != null) {
      var snackBar = SnackBar(
        content: Text('Event ${event.name} added successfully'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      await database.eventDao.insertEvent(event);
      setState(() {});
    }
  }

  Future<List<Event>> getEvents() async {
    return database.eventDao.findAllEvents();
  }

  Widget buildEventsList() {
    return FutureBuilder<List<Event>>(
        future: getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            events = snapshot.data!;
            var ev = snapshot.data!;
            return HomePage(events: ev);
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
