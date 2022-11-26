part of 'user_bloc.dart';

@immutable
abstract class UserSessionEvent extends Equatable {
  const UserSessionEvent();
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends UserSessionEvent {
  final String newName;
  const RegisterUserEvent(this.newName);
}

class ImportExistingUserEvent extends UserSessionEvent {
  final Map<String, dynamic> currentUserData;
  const ImportExistingUserEvent(this.currentUserData);
}
// class RegisterUser extends UserEvent {}

