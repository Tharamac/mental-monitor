part of 'user_bloc.dart';

@immutable
class UserState {
  final String name;
  final List<DailyRecord> records;

  UserState({required this.name, List<DailyRecord>? records})
      : records = records ?? [];

  UserState copyWith({String? name, List<DailyRecord>? records}) {
    return UserState(name: name ?? this.name, records: records ?? this.records);
  }

  @override
  String toString() {
    return "name: $name, records: $records";
  }

  @override
  List<Object> get props => [name];
}

class UserInitial extends UserState {
  UserInitial() : super(name: "", records: []);
}
