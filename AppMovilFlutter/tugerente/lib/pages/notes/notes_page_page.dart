import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/notes/notes_bloc.dart';
import 'package:tugerente/pages/notes/note_screen.dart';
import 'package:tugerente/repositories/note/note_repository.dart';

class NotePage extends StatelessWidget {
  final NoteRepository noteRepository;

  NotePage({Key key, @required this.noteRepository})
      : assert(noteRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: BlocProvider(
        create: (context) {
          return NotesBloc(
            noteRepository: noteRepository,
          );
        },
        child: NoteScreen(noteRepository: noteRepository),
      ),
    );
  }
}
