import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/groups/groups_bloc.dart';
import 'package:tugerente/models/group_model.dart';
import 'package:tugerente/repositories/group/group_repository.dart';
import 'package:tugerente/utils/utils.dart';

class GroupScreen extends StatefulWidget {
  final GroupRepository groupRepository;

  GroupScreen({Key key, @required this.groupRepository})
      : assert(groupRepository != null),
        super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final _nameController = TextEditingController();
  Group selectedGroup;
  List<Group> groups;

  @override
  @override
  initState() {
    super.initState();
    _fetchList();
  }

  Future _fetchList() async {
    var data = await widget.groupRepository.getgroups();
    setState(() {
      groups = data;
    });
  }

  Widget build(BuildContext context) {
    _onSubmit() {
      BlocProvider.of<GroupBloc>(context).add(
        FormSubmit(
          name: _nameController.text,
        ),
      );
    }

    return BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is GroupSuccess) {
          mostrarAlerta(context, 'mensaje');
        }
      },
      child: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(58.0),
            child: Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      hintText: 'ejemplo@correo.com',
                      labelText: 'Name',
                    ),
                    controller: _nameController,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: _onSubmit,
                    // onPressed: null,
                    child: Text('Submit'),
                  ),
                  Container(
                    child: state is GroupLoading ? CircularProgressIndicator() : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
