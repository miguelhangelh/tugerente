import 'dart:async';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tugerente/bloc/authentication/authentication.dart';
import 'package:tugerente/bloc/authentication/authentication_bloc.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        await userRepository.register(
          username: event.username,
          password: event.password,
          email: event.email,
        );
        yield RegisterLogin();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
    if (event is RegisterLoginButton) {
      final token = await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );
      authenticationBloc.add(LoggedIn(token: token));
    }
  }
}
