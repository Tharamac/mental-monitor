// part of 'record_form_cubit.dart';

import 'package:flutter/material.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';

@immutable
class RecordFormState {
  final DailyRecord? currentRecord;
  final List<DailyRecord>? updatedRecords;

 const RecordFormState({
    this.updatedRecords,
    this.currentRecord,
  });

  RecordFormState copyWith({DailyRecord? newRecord, List<DailyRecord>? newUpdatedRecords}) =>
      RecordFormState(
        currentRecord: newRecord ?? currentRecord,
        updatedRecords: newUpdatedRecords ?? updatedRecords,
      );
  //     {String? name,
  //     List<DailyRecord>? records,
  //     bool? isTodayRecorded,
  //     DailyRecord? todayRecord,
  //     DateTime? notifiedTime}) {
  //   return UserSessionState(
  //       name: name ?? this.name,
  //       records: records ?? this.records,
  //       isTodayRecorded: isTodayRecorded ?? this.isTodayRecorded,
  //       todayRecord: todayRecord,
  //       notifiedTime: notifiedTime ??  this.notifiedTime);
  // }

  // UserSessionState clearTodayRecord() {
  //   return UserSessionState(
  //       name: name,
  //       records: records,
  //       isTodayRecorded: false,
  //       todayRecord: null);
  // }

//   @override
//   String toString() {
//     return "rec,";
//   }

//   @override
//   List<Object> get props => records;
}

class RecordFormInitial extends RecordFormState {
  const RecordFormInitial() : super();
}
