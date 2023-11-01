import 'dart:convert';

import 'package:apollo/component/event/tile.dart';
import 'package:apollo/object/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProv extends ChangeNotifier {
  final events = <EventTile?>[];
  int selected = 0;
  int stockSelected = 0;
  int notifCount = 0;

  void sendNotification() {
    notifCount = 1;
    notify();
    getAlertEvent();
    Future.delayed(Duration(seconds: 2)).then((value) {
      notifCount = 0;
      notify();
    });
  }

  HomeProv() {
    getEvents();
  }

  void select(int index) {
    selected = index;
    notify();
  }

  void stock_select(int index) {
    stockSelected = index;
    notify();
  }

  Future<void> getEvents() async {
    late final List<Map<String, dynamic>> eventList;
    try {
      final response =
          await http.get(Uri.parse("http://3.1.30.54:8080/get_events"));
      if (response.statusCode != 200) {
        return;
      }
      eventList = List<Map<String, dynamic>>.from(json.decode(response.body));
    } catch (_) {
      rethrow;
      return;
    }
    if (eventList.isEmpty) {
      return;
    }
    for (var i = 0; i < eventList.length; i++) {
      events.add(null);
      loadEvent(i, eventList[i]);
    }
  }

  Future<void> loadEvent(int index, Map<String, dynamic> data) async {
    if (data.isEmpty) {
      return;
    }
    late final String image;
    try {
      final response = await http.get(
        Uri.parse(
            "http://3.1.30.54:8080/get_image?path=event/${data["id"]}.jpg"),
      );
      if (response.statusCode != 200) {
        return;
      }
      image = response.body;
      if (image.isEmpty) {
        return;
      }
    } catch (_) {
      rethrow;
      return;
    }
    data['image'] = image;
    events[index] = EventTile(index: index, data: EventData(data, image));
    notify();
  }

  void notify() {
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<void> getAlertEvent() async {
    late final Map<String, dynamic> e;
    try {
      final response =
          await http.get(Uri.parse("http://3.1.30.54:8080/update"));
      if (response.statusCode != 200) {
        return;
      }
      e = Map<String, dynamic>.from(json.decode(response.body));
    } catch (_) {
      rethrow;
      return;
    }
    if (e.isEmpty) {
      return;
    }
    loadEvent(selected, e);
  }
}
