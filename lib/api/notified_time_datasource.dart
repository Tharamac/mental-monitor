import 'package:shared_preferences/shared_preferences.dart';

const notifiedTimeKey = "notified_time";


class NotifiedTimeDataSource {
  static final NotifiedTimeDataSource _singleton = NotifiedTimeDataSource._internal();

  factory NotifiedTimeDataSource() {
    return _singleton;
  }
  
  void saveNotifiedTime(DateTime notifiedTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(notifiedTimeKey, notifiedTime.toIso8601String());
  }

  Future<DateTime?> loadNotifiedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loadedNotifiedTime = prefs.getString(notifiedTimeKey);
    final notifiedTime = DateTime.tryParse(loadedNotifiedTime ?? '');
    return notifiedTime;
  }

  void resetNotifiedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(notifiedTimeKey);
  }

  NotifiedTimeDataSource._internal();
}

