import 'package:duration/duration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DailyRecord extends Equatable {
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

  factory DailyRecord.emptyRecord(DateTime date) {
    return DailyRecord(
        recordDate: date,
        moodLevel: 5,
        howWasYourDay: "",
        sleepTime: Duration.zero);
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      recordDate: DateTime.parse(json["record_date"]),
      moodLevel: json["mood_level"],
      howWasYourDay: json["how_was_your_day"],
      sleepTime: Duration(hours: json["sleep_time"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'record_date': recordDate.toIso8601String(),
        'mood_level': moodLevel,
        'how_was_your_day': howWasYourDay,
        'sleep_time': sleepTime.inHours
      };

  static List<String> get getFieldName =>
      ['วันที่บันทึก', 'เวลาบันทึก', 'ระดับอารมณ์', 'บันทึก', 'เวลานอนรวม'];

  @override
  // TODO: implement props
  List<Object?> get props => [recordDate, moodLevel, howWasYourDay, sleepTime];
}
