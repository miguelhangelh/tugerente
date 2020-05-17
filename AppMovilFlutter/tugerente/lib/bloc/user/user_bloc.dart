import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FormSubmitGroup) {
      yield UserLoading();
      try {
        await userRepository.addGroup(
          groupcode: event.groupcode,
          usercode: event.usercode,
        );

        yield UserSuccess();
      } catch (error) {
        yield UserFailure(error: error.toString());
      }
    }
  }
}
