import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mental_monitor/constant/constant.dart';
import 'package:mental_monitor/file_manager.dart';
import 'package:mental_monitor/model/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<RegisterUserEvent>((event, emit) {
      final User newUser = User(name: event.newName);
      final FileManager newRecordsFile = FileManager(fileName: currentUserFile);
      newRecordsFile.writedata(newUser.toJson().toString());
      state.copyWith(name: event.newName);
    });
  }
}
