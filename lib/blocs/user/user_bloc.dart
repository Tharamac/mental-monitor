import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mental_monitor/api/notified_time_datasource.dart';
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
      print("Registered ${jsonEncode(newUser.toJson())}");
      newRecordsFile.writedata(jsonEncode(
        newUser.toJson(),
      ));
      emit(state.copyWith(name: event.newName));
    });

    on<ImportExistingUserEvent>((event, emit) {
      // todo implement current note check
      final existingUser = User.fromJson(event.currentUserData);
      bool isTodayRecorded = false;
      existingUser.records.sort((a, b) => b.recordDate.compareTo(a.recordDate));
      if (existingUser.records.isNotEmpty) {
        final latestRecordedDateTime = existingUser.records[0].recordDate;
        final latestRecordedDate = DateTime(latestRecordedDateTime.year,
            latestRecordedDateTime.month, latestRecordedDateTime.day);

        final today = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        isTodayRecorded = today.compareTo(latestRecordedDate) == 0;
      }

      // print(today.compareTo(latestRecordedDate) == 0);
      emit(
        state.copyWith(
          name: existingUser.name,
          records: existingUser.records.toList(),
          isTodayRecorded: isTodayRecorded,
          todayRecord: isTodayRecorded ? existingUser.records.first : null,
        ),
      );
    });

    on<UpdateDailyRecord>(((event, emit) {
      var currentList = <DailyRecord>[];
      if (state.todayRecord != null) {
        state.records.first = event.dailyRecord;
        currentList = state.records;
      } else {
        currentList = [event.dailyRecord, ...state.records];
      }
      final savedUser = User(name: state.name, records: currentList);
      final FileManager updateRecordsFile =
          FileManager(fileName: currentUserFile);
      updateRecordsFile.writedata(jsonEncode(
        savedUser.toJson(),
      ));

      emit(state.copyWith(
        todayRecord: event.dailyRecord,
        records: currentList,
      ));
    }));
    on<ArchiveRecord>((event, emit) {
      if (state.todayRecord == null) return;
      // final newList = [state.todayRecord!, ...state.records];
      emit(state.clearTodayRecord());
      // emit(state.copyWith(records: state.records));
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
      updateRecordsFile.writedata(jsonEncode(
        savedUser.toJson(),
      ));

      emit(state.copyWith(
        notifiedTime: notifiedTime,
      ));
    });

    on<LoadNotifiedTime>(
      (event, emit) {},
    );

    on<ReDailyRecord>(((event, emit) {
      emit(state.copyWith(
        isTodayRecorded: false,
        todayRecord: null,
      ));
    }));
  }
}
