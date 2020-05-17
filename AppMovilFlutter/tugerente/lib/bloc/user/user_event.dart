part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FormSubmitGroup extends UserEvent {
  final int usercode;
  final int groupcode;

  const FormSubmitGroup({
    @required this.usercode,
    @required this.groupcode,
  });

  @override
  List<Object> get props => [usercode, groupcode];

  @override
  String toString() => 'LoginButtonPressed { usercode: $usercode, groupcode: $groupcode }';
}
