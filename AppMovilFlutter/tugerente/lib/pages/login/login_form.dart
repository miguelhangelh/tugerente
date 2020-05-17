import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/authentication/authentication.dart';
import 'package:tugerente/bloc/login/login_bloc.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  LoginForm({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _usernameController.text = "miguelhangelh@hotmail.com";
    _passwordController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      hintText: 'ejemplo@correo.com',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      labelText: 'password',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: state is LoginLoading ? CircularProgressIndicator() : null,
                  ),
                  Text('Or '),
                  Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(RegisterIn());
                      },
                      child: Text('Register', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
