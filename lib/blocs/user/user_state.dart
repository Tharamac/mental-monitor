part of 'user_bloc.dart';

@immutable
class UserSessionState {
  final String name;
  final List<DailyRecord> records;
  // final User 
  final bool isTodayRecorded;
  final DailyRecord? todayRecord;
  final User? existingUserSession;

  UserSessionState(
      {required this.name,
      List<DailyRecord>? records,
      this.isTodayRecorded = false,
      this.todayRecord,
      this.existingUserSession})
      : records = records ?? [];

  UserSessionState copyWith(
      {String? name,
      List<DailyRecord>? records,
      bool? isTodayRecorded,
      DailyRecord? todayRecord}) {
    return UserSessionState(
        name: name ?? this.name,
        records: records ?? this.records,
        isTodayRecorded: isTodayRecorded ?? this.isTodayRecorded,
        todayRecord: todayRecord ?? this.todayRecord);
  }

  @override
  String toString() {
    return "name: $name, records: $records, todayRecord: $todayRecord";
  }

  @override
  List<Object> get props => [name];
}

class UserInitial extends UserSessionState {
  UserInitial() : super(name: "", records: []);
}
