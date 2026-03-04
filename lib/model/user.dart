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
                DateTime.now().day, 19, 0, 0);

  @override
  String toString() => 'name: $name, records: $records';

  factory User.fromJson(Map<String, dynamic> json) {
    var records = jsonDecode(json['records']) as List;
    final dailyRecords = records
        .map((recordJson) => recordJson as Map<String, dynamic>)
        .toList()
        .map((e) => DailyRecord.fromJson(e))
        .toList();
    print(dailyRecords);

    return User(
        name: json["name"],
        notificationTime: DateTime.parse(json["notified_time"]),
        records: dailyRecords);
  }

  Map<String, dynamic> toJson() {
    records.sort((a, b) => b.recordDate.compareTo(a.recordDate));
    print(Duration(minutes: 480));
    return {
      'name': name,
      'records': jsonEncode(records),
      "notified_time": notificationTime.toIso8601String()
    };
  }
}
