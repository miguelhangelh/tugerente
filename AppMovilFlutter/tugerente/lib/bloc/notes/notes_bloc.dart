import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tugerente/repositories/note/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository noteRepository;

  NotesBloc({
    @required this.noteRepository,
  }) : assert(noteRepository != null);

  @override
  NotesState get initialState => NotesInitial();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is FormSubmit) {
      yield NotesLoading();
      try {
        await noteRepository.add(
          title: event.title,
          detail: event.detail,
          groupcode: event.groupcode,
        );

        yield NotesSuccess();
      } catch (error) {
        yield NotesFailure(error: error.toString());
      }
    }
  }
}
