part of 'groups_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupSuccess extends GroupState {}

class GroupLoading extends GroupState {}

class GroupFailure extends GroupState {
  final String error;

  const GroupFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GroupFailure { error: $error }';
}
