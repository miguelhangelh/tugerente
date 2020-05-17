import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/notes/notes_bloc.dart';
import 'package:tugerente/bloc/user/user_bloc.dart';
import 'package:tugerente/pages/notes/note_screen.dart';
import 'package:tugerente/pages/usergroup/user_group_screen.dart';
import 'package:tugerente/repositories/note/note_repository.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

class UserGroupPage extends StatelessWidget {
  final NoteRepository noteRepository;
  final UserRepository userRepository;
  UserGroupPage({Key key, @required this.noteRepository, this.userRepository})
      : assert(noteRepository != null, userRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASIGN GROUPS'),
      ),
      body: BlocProvider(
        create: (context) {
          return UserBloc(
            userRepository: userRepository,
          );
        },
        child: UserGroupScreen(noteRepository: noteRepository, userRepository: userRepository),
      ),
    );
  }
}
