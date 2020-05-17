import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/authentication/authentication_bloc.dart';
import 'package:tugerente/bloc/authentication/authentication_event.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Guardado correctamente!'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(
                      Back(),
                    ))
          ],
        );
      });
}
