import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/api/notified_time_datasource.dart';
import 'package:mental_monitor/blocs/record_form/record_form_state.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';

import '../notified_time/notified_state.dart';

class RecordFormCubit extends Cubit<RecordFormState> {
  RecordFormCubit() : super(const RecordFormInitial());

  void loadLatestRecords(List<DailyRecord> records) {
    emit(state.copyWith(newUpdatedRecords: records));
  }

  void changeRecordByDate(DateTime selectedDateTime) {
    final selectRecord = state.updatedRecords?.firstWhere(
          (element) => element.recordDate == selectedDateTime,
          orElse: () => DailyRecord.emptyRecord(selectedDateTime),
        ) ??
        DailyRecord.emptyRecord(selectedDateTime);
    emit(state.copyWith(newRecord: selectRecord));
  }

  // void updateNotifiedTimeSetting(TimeOfDay time) {
  //   LocalNoticeService().cancelNotification(0);
  //   LocalNoticeService().showDailyNotificationAtTime(0, "วันนี้เป็นอย่างไรบ้าง",
  //       "บันทึกเรื่องราววันนี้ได้เลย", "notify memo", time);
  //   NotifiedTimeDataSource().saveNotifiedTime(time);
  //   emit(NotifiedTimeSetState(time));
  // }

  // void loadNotifiedTimeSetting() async {
  //   final loadNotifiedTime = await NotifiedTimeDataSource().loadNotifiedTime();
  //   LocalNoticeService().cancelNotification(0);
  //   LocalNoticeService().showDailyNotificationAtTime(0, "วันนี้เป็นอย่างไรบ้าง",
  //       "บันทึกเรื่องราววันนี้ได้เลย", "notify memo", loadNotifiedTime);
  //   emit(NotifiedTimeSetState(loadNotifiedTime));
  // }
}
