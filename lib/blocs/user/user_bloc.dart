import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mental_monitor/constant/constant.dart';
import 'package:mental_monitor/file_manager.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionBloc() : super(UserInitial()) {
    on<RegisterUserEvent>((event, emit) {
      final User newUser = User(name: event.newName);
      final FileManager newRecordsFile = FileManager(fileName: currentUserFile);
      newRecordsFile.writedata(newUser.toJson().toString());
      emit(state.copyWith(name: event.newName));
    });

    on<ImportExistingUserEvent>((event, emit) {
      // todo implement current note check
      final existingUser = User.fromJson(event.currentUserData);
      existingUser.records.sort((a, b) => b.recordDate.compareTo(a.recordDate));
      final latestRecordedDateTime = existingUser.records[0].recordDate;
      final latestRecordedDate = DateTime(latestRecordedDateTime.year,
          latestRecordedDateTime.month, latestRecordedDateTime.day);
      final today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      // print(today.compareTo(latestRecordedDate) == 0);
      emit(
        state.copyWith(
          name: existingUser.name,
          records: existingUser.records.skip(1).toList(),
          isTodayRecorded: today.compareTo(latestRecordedDate) == 0,
          todayRecord: today.compareTo(latestRecordedDate) == 0
              ? existingUser.records[0]
              : null,
        ),
      );
    });

    on<UpdateDailyRecord>(((event, emit) {
      final newList = [event.dailyRecord, ...state.records];
      final savedUser = User(name: state.name, records: newList);
      final FileManager updateRecordsFile =
          FileManager(fileName: currentUserFile);
      updateRecordsFile.writedata(savedUser.toJson().toString());

      emit(state.copyWith(todayRecord: event.dailyRecord));
    }));
    on<ArchiveRecord>((event, emit) {
      if (state.todayRecord == null) return;
      print("update");
      final newList = [state.todayRecord!, ...state.records];
      emit(state.clearTodayRecord());
      emit(state.copyWith(
        records: newList,
      ));
    });
    on<UpdateNotifiedTime>((event, emit) {
      DateTime notifiedTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          event.notifiedTime.hour,
          event.notifiedTime.minute,
          0);
      final savedUser = User(
          name: state.name,
          records: state.records,
          notificationTime: notifiedTime);
      final FileManager updateRecordsFile =
          FileManager(fileName: currentUserFile);
      updateRecordsFile.writedata(savedUser.toJson().toString());

      emit(state.copyWith(
        notifiedTime: notifiedTime,
      ));
    });
  }
}
