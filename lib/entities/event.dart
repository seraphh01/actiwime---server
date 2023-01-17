// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Event {
  @primaryKey
  final int id;
  String name;
  String date;
  String location;

  Event(
      {required this.id,
      required this.name,
      required this.date,
      this.location = ""});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        date: json['date'],
        location: json['location']);
  }
}
