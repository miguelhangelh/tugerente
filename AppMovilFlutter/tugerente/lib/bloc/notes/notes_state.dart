part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesSuccess extends NotesState {}

class NotesLoading extends NotesState {}

class NotesFailure extends NotesState {
  final String error;

  const NotesFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'NotesFailure { error: $error }';
}
