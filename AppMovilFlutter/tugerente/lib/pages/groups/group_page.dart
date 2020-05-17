import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/groups/groups_bloc.dart';
import 'package:tugerente/pages/groups/group_screen.dart';
import 'package:tugerente/repositories/group/group_repository.dart';

class GroupPage extends StatelessWidget {
  final GroupRepository groupRepository;

  GroupPage({Key key, @required this.groupRepository})
      : assert(groupRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos'),
      ),
      body: BlocProvider(
        create: (context) {
          return GroupBloc(
            groupRepository: groupRepository,
          );
        },
        child: GroupScreen(groupRepository: groupRepository),
      ),
    );
  }
}
