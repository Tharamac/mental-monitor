import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const notifiedTimeHrKey = "notified_time_hr";
const notifiedTimeMinKey = "notified_time_min";

class NotifiedTimeDataSource {
  static final NotifiedTimeDataSource _singleton =
      NotifiedTimeDataSource._internal();

  factory NotifiedTimeDataSource() {
    return _singleton;
  }

  void saveNotifiedTime(TimeOfDay notifiedTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(notifiedTimeHrKey, notifiedTime.hour);
    await prefs.setInt(notifiedTimeMinKey, notifiedTime.minute);
  }

  Future<TimeOfDay> loadNotifiedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int loadedNotifiedHr = prefs.getInt(notifiedTimeHrKey) ?? 19;
    int loadedNotifiedMin = prefs.getInt(notifiedTimeMinKey) ?? 0;
    final notifiedTime =
        TimeOfDay(hour: loadedNotifiedHr, minute: loadedNotifiedMin);
    return notifiedTime;
  }

  void resetNotifiedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(notifiedTimeHrKey);
    await prefs.remove(notifiedTimeMinKey);
  }

  NotifiedTimeDataSource._internal();
}
