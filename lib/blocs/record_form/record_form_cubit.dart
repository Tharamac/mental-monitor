import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/api/notified_time_datasource.dart';
import 'package:mental_monitor/blocs/record_form/record_form_state.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/model/core/datetime_expansion.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';

import '../notified_time/notified_state.dart';

class RecordFormCubit extends Cubit<RecordFormState> {
  RecordFormCubit() : super(const RecordFormInitial());

  void loadLatestRecords(List<DailyRecord> records) {
    final today = DateTime.now().dateOnly;
    final DailyRecord todayRecord = records.firstWhere((element) {
      final recordDate = element.recordDate.dateOnly;
      return today.compareTo(recordDate) == 0;
    }, orElse: () => DailyRecord.emptyRecord(today));
    emit(state.copyWith(newUpdatedRecords: records, newRecord: todayRecord));
  }

  void changeRecordByDate(DateTime selectedDateTime) {
    final selectedDate = selectedDateTime.dateOnly;
    final selectRecord = state.updatedRecords?.firstWhere(
          (element) {
            return selectedDateTime.dateOnly
                    .compareTo(element.recordDate.dateOnly) ==
                0;
          },
          orElse: () => DailyRecord.emptyRecord(selectedDate),
        ) ??
        DailyRecord.emptyRecord(selectedDateTime);
    emit(state.copyWith(newRecord: selectRecord));
  }

  void updateData(
      {int? newMoodLevel, String? newHowWasYourDay, Duration? newSleepTime}) {
    if (state.currentWorkingRecord != null) {
      emit(state.copyWith(
          newRecord: state.currentWorkingRecord!
              .copyWith(newMoodLevel, newHowWasYourDay, newSleepTime)));
    }
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
