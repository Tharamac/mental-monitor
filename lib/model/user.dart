import 'package:mental_monitor/model/daily_record.dart';

class User {
  final String name;
  final List<DailyRecord> records;
  User({
    required this.name,
    List<DailyRecord>? records,
  }) : records = records ?? [];

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        records = json["records"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'record': records,
      };
}
