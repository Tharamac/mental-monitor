part of 'user_bloc.dart';

@immutable
class UserSessionState {
  final String name;
  final List<DailyRecord> records;
  final bool isTodayRecorded;

  UserSessionState(
      {required this.name,
      List<DailyRecord>? records,
      this.isTodayRecorded = false})
      : records = records ?? [];

  UserSessionState copyWith(
      {String? name, List<DailyRecord>? records, bool? isTodayRecorded}) {
    return UserSessionState(
        name: name ?? this.name,
        records: records ?? this.records,
        isTodayRecorded: isTodayRecorded ?? this.isTodayRecorded);
  }

  @override
  String toString() {
    return "name: $name, records: $records";
  }

  @override
  List<Object> get props => [name];
}

class UserInitial extends UserSessionState {
  UserInitial() : super(name: "", records: []);
}
