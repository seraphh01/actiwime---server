// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Event {
  @primaryKey
  final int id;

  String name;
  String description;

  Event({required this.id, required this.name, required this.description});
}
