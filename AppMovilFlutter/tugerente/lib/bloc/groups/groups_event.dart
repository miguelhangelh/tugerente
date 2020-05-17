part of 'groups_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();
}

class FormSubmit extends GroupEvent {
  final String name;

  const FormSubmit({
    @required this.name,
  });

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'LoginButtonPressed {name: $name }';
}
