import 'package:actiwime/dao/event_dao.dart';
import 'package:actiwime/database/database.dart';
import 'package:actiwime/entities/event.dart';
import 'package:actiwime/navigator.dart';
import 'package:flutter/material.dart';

late AppDatabase database;
late EventDao eventsDao;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("hello");

  database = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  // eventsDao = database.eventDao;
  // for (int i = 4; i < 11; i++) {
  //   await eventsDao
  //       .insertEvent(Event(id: i, name: "name", description: "description3"));
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actiwime',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const NavigatorScreen(),
    );
  }
}
