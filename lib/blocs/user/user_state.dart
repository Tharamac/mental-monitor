part of 'user_bloc.dart';

@immutable
class UserState {
  final String name;

  const UserState({required this.name});

  UserState copyWith({String? name}) {
    return UserState(name: name ?? "");
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name: $name";
  }

  @override
  List<Object> get props => [name];
}

class UserInitial extends UserState {
  const UserInitial() : super(name: "");
}
