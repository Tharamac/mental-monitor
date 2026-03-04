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

  factory User.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = jsonDecode(json["name"]);
    final finalList = list.map((data) => DailyRecord.fromJson(data)).toList();
    print(finalList);
    return User(name: json["name"], records: finalList);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'record': records,
      };
}
