// database.dart

// required package imports
import 'dart:async';
import 'package:actiwime/dao/event_dao.dart';
import 'package:actiwime/entities/event.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Event])
abstract class AppDatabase extends FloorDatabase {
  EventDao get eventDao;
}
