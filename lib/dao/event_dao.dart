// dao/person_dao.dart

import 'package:actiwime/entities/event.dart';
import 'package:floor/floor.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  @Query('SELECT * FROM Event WHERE id = :id')
  Stream<Event?> findEventById(int id);

  @insert
  Future<int> insertEvent(Event person);

  @Query('DELETE from Event WHERE id = :id')
  Future<Event?> deleteEvent(int id);

  @update
  Future<void> updateEvent(Event event);
}
