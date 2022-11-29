import 'dart:async';
import 'dart:convert';

import 'package:mental_monitor/model/daily_record.dart';

class User {
  final String name;
  List<DailyRecord> records;
  DateTime notificationTime;

  User({
    required this.name,
    List<DailyRecord>? records,
    DateTime? notificationTime,
    // DateTime timeNotified,
  })  : records = records ?? [],
        notificationTime = notificationTime ??
          DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 19, 0, 0)  ;

  @override
  String toString() => 'name: $name, records: $records';

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        records = json["records"],
        notificationTime = DateTime.parse(json["notified_time"]);

  Map<String, dynamic> toJson() {
    records.sort((a, b) => b.recordDate.compareTo(a.recordDate));
    return {
      'name': name,
      'records': records,
      "notified_time": notificationTime.toIso8601String()
    };
  }
}
