import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/register/register_bloc.dart';
import 'package:tugerente/pages/register/register_form.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

import 'package:tugerente/bloc/authentication/authentication.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(),
      ),
    );
  }
}
