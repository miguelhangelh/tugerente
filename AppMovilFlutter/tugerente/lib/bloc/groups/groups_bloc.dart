import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tugerente/repositories/group/group_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc({
    @required this.groupRepository,
  }) : assert(groupRepository != null);

  @override
  GroupState get initialState => GroupInitial();

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if (event is FormSubmit) {
      yield GroupLoading();
      try {
        await groupRepository.add(
          name: event.name,
        );
        yield GroupSuccess();
      } catch (error) {
        yield GroupFailure(error: error.toString());
      }
    }
  }
}
