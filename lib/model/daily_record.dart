import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

class DailyRecord {
  final DateTime recordDate;
  final int moodLevel;
  final String howWasYourDay;
  final Duration sleepTime;
  DailyRecord({
    required this.recordDate,
    required this.moodLevel,
    required this.howWasYourDay,
    required this.sleepTime,
  });

  @override
  String toString() =>
      'DailyRecord(recordDate: $recordDate, moodLevel: $moodLevel, howWasYourDay: $howWasYourDay, sleepTime: $sleepTime)';

  // factory DailyRecord.fromJson(Map<String, dynamic> json)
  // DailyRecord.fromJson(Map<String, dynamic> json)
  //     : recordDate = DateTime.parse(json["record_date"]),
  //       moodLevel = json["mood_level"],
  //       howWasYourDay = json["how_was_your_day"],
  //       sleepTime = Duration(minutes: json["sleep_time"]);

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      recordDate: DateTime.parse(json["record_date"]),
      moodLevel: json["mood_level"],
      howWasYourDay: json["how_was_your_day"],
      sleepTime: Duration(minutes: json["sleep_time"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'record_date': recordDate.toIso8601String(),
        'mood_level': moodLevel,
        'how_was_your_day': howWasYourDay,
        'sleep_time': sleepTime.inMinutes
      };

  static List<String> get getFieldName =>
      ['Record Date', 'Record Time', 'Mood Level', 'Description', 'Sleep Time'];
}
