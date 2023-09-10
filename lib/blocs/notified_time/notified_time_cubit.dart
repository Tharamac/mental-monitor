import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/api/notified_time_datasource.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';

import 'notified_state.dart';

class NotfiedTimeCubit extends Cubit<NotifiedTimeState> {
  NotfiedTimeCubit() : super(NotifiedTimeInitState()) {
    loadNotifiedTimeSetting();
  }

  void updateNotifiedTimeSetting(TimeOfDay time) {
    LocalNoticeService().cancelNotification(0);
    LocalNoticeService().showDailyNotificationAtTime(0, "วันนี้เป็นอย่างไรบ้าง",
        "บันทึกเรื่องราววันนี้ได้เลย", "notify memo", time);
    NotifiedTimeDataSource().saveNotifiedTime(time);
    emit(NotifiedTimeSetState(time));
  }

  void loadNotifiedTimeSetting() async {
    final loadNotifiedTime = await NotifiedTimeDataSource().loadNotifiedTime();
    LocalNoticeService().cancelNotification(0);
    LocalNoticeService().showDailyNotificationAtTime(0, "วันนี้เป็นอย่างไรบ้าง",
        "บันทึกเรื่องราววันนี้ได้เลย", "notify memo", loadNotifiedTime);
    emit(NotifiedTimeSetState(loadNotifiedTime));
  }
}
