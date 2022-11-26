import 'dart:async';
import 'dart:convert';

import 'package:mental_monitor/model/daily_record.dart';

class User {
  final String name;
  List<DailyRecord> records;
  User({
    required this.name,
    List<DailyRecord>? records,
  }) : records = records ?? [];

  @override
  String toString() => 'name: $name, records: $records';

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        records = json["records"];

  Map<String, dynamic> toJson() {
    records.sort((a, b) => b.recordDate.compareTo(a.recordDate));
    return {'name': name, 'records': records};
  }
}
