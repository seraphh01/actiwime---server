import 'dart:convert';

import 'package:actiwime/entities/event.dart';
import 'package:http/http.dart' as http;

class Server {
  static Future<Event> getEvent(int id) async {
    var response = await http
        .get(Uri.parse('http://127.0.0.1:5000/events/$id'), headers: {});

    print(response.body);

    return Event.fromJson(jsonDecode(response.body));
  }
}
