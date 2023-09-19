import 'package:duration/duration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mental_monitor/model/core/datetime_expansion.dart';

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
  bool isUpdate(DailyRecord recent) {
    return !recordDate.dateOnly.isAtSameMomentAs(recent.recordDate.dateOnly) ||
        howWasYourDay != recent.howWasYourDay ||
        moodLevel != recent.moodLevel ||
        sleepTime != recent.sleepTime;
  }

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

  DailyRecord copyWith(int? newMoodLevel, String? newHowWasYourDay,
          Duration? newSleepTime) =>
      DailyRecord(
          recordDate: recordDate,
          moodLevel: newMoodLevel ?? moodLevel,
          howWasYourDay: newHowWasYourDay ?? howWasYourDay,
          sleepTime: newSleepTime ?? sleepTime);

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
