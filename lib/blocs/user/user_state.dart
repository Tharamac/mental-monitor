part of 'user_bloc.dart';

@immutable
class UserSessionState {
  final String name;
  final List<DailyRecord> records;
  // final User
  final bool isTodayRecorded;
  final DailyRecord? todayRecord;
  final User? existingUserSession;
  final DateTime? notifiedTime;

  UserSessionState(
      {required this.name,
      List<DailyRecord>? records,
      this.isTodayRecorded = false,
      this.todayRecord,
      this.existingUserSession,
      DateTime? notifiedTime})
      : records = records ?? [],
        notifiedTime = notifiedTime ??
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 19, 0, 0);

  UserSessionState copyWith(
      {String? name,
      List<DailyRecord>? records,
      bool? isTodayRecorded,
      DailyRecord? todayRecord,
      DateTime? notifiedTime}) {
    return UserSessionState(
        name: name ?? this.name,
        records: records ?? this.records,
        isTodayRecorded: isTodayRecorded ?? this.isTodayRecorded,
        todayRecord: todayRecord,
        notifiedTime: notifiedTime ??  this.notifiedTime);
  }

  UserSessionState clearTodayRecord() {
    return UserSessionState(
        name: name,
        records: records,
        isTodayRecorded: false,
        todayRecord: null);
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
