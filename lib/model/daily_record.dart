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

  DailyRecord.fromJson(Map<String, dynamic> json)
      : recordDate = json["record_date"],
        moodLevel = json["mood_level"],
        howWasYourDay = json["how_was_your_day"],
        sleepTime = json["sleep_time"];

  Map<String, dynamic> toJson() => {
        'record_date': recordDate,
        'mood_level': moodLevel,
        'how_was_your_day': howWasYourDay,
        'sleep_time': sleepTime
      };
}
