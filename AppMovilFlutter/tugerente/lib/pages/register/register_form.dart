import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/login/login_bloc.dart';
import 'package:tugerente/bloc/register/register_bloc.dart';
import 'package:tugerente/pages/home/home.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _usernameController.text = "miguel";
    _passwordController.text = "123456";
    _emailController.text = 'miguelhangelh1@hotmail.coml';
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
          email: _emailController.text,
        ),
      );
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is RegisterLogin) {
          BlocProvider.of<RegisterBloc>(context).add(
            RegisterLoginButton(
              username: _emailController.text,
              password: _passwordController.text,
            ),
          );
        }
        if (state is RegisterSuccess) {}
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(38.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('REGISTER',
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
                      labelText: 'username',
                    ),
                    keyboardType: TextInputType.text,
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
                  TextFormField(
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
                    controller: _emailController,
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: double.maxFinite,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: state is! RegisterLoading ? _onLoginButtonPressed : null,
                        child: Text('Register', style: TextStyle(color: Colors.white)),
                      )),
                  Container(
                    child: state is RegisterLoading ? CircularProgressIndicator() : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
