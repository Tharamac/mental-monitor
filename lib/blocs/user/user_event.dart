part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends UserEvent {
  final String newName;
  const RegisterUserEvent(this.newName);
}

class ImportExistingUserEvent extends UserEvent {
  final Map<String, dynamic> currentUserData;
  const ImportExistingUserEvent(this.currentUserData);
}
// class RegisterUser extends UserEvent {}

