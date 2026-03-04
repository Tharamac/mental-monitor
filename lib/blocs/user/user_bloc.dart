import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      // newRecordsFile.writedata(newUser.toJson().toString());
      print(event.newName);
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

      print(today.compareTo(latestRecordedDate) == 0);
      emit(state.copyWith(
          name: existingUser.name,
          records: existingUser.records,
          isTodayRecorded: today.compareTo(latestRecordedDate) == 0));
    });

    on<UpdateDailyRecord>(((event, emit) {
      final newList = [event.dailyRecord, ...state.records];
      final savedUser = User(name: state.name, records: newList);
      final FileManager updateRecordsFile =
          FileManager(fileName: currentUserFile);
      // updateRecordsFile.writedata(savedUser.toJson.toString);

      emit(state.copyWith(todayRecord: event.dailyRecord));
    }));
    on<ArchiveRecord>((event, emit) {
      final newList = [state.todayRecord!, ...state.records];
      emit(state.copyWith(
        todayRecord: null,
        records: newList,
      ));
    });
  }
}
