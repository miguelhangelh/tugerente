part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class FormSubmit extends NotesEvent {
  final String title;
  final String detail;
  final int groupcode;

  const FormSubmit({
    @required this.title,
    @required this.detail,
    @required this.groupcode,
  });

  @override
  List<Object> get props => [title, detail, groupcode];

  @override
  String toString() => 'LoginButtonPressed { title: $title, detail: $detail , groupcode: $groupcode}';
}
