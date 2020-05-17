import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/pages/login/login_page.dart';
import 'package:tugerente/pages/register/register_page.dart';
import 'package:tugerente/preferencias_usuario/preferencias_usuario.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

import 'package:tugerente/bloc/authentication/authentication.dart';
import 'package:tugerente/splash/splash.dart';
import 'package:tugerente/pages/home/home.dart';
import 'package:tugerente/common/common.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          if (state is Register) {
            return RegisterPage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
    );
  }
}
