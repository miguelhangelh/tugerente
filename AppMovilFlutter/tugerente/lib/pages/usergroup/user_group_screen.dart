import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/user/user_bloc.dart';
import 'package:tugerente/models/group_model.dart';
import 'package:tugerente/models/user_model.dart';
import 'package:tugerente/repositories/note/note_repository.dart';
import 'package:tugerente/repositories/user/user_repository.dart';
import 'package:tugerente/utils/utils.dart';

class UserGroupScreen extends StatefulWidget {
  final NoteRepository noteRepository;
  final UserRepository userRepository;

  UserGroupScreen({Key key, @required this.noteRepository, @required this.userRepository})
      : assert(noteRepository != null, userRepository != null),
        super(key: key);

  @override
  State<UserGroupScreen> createState() => _UserGroupScreenState();
}

class _UserGroupScreenState extends State<UserGroupScreen> {
  Group selectedGroup;
  User selectedUser;
  List<Group> groups;
  List<User> users;

  @override
  @override
  initState() {
    super.initState();
    _fetchList();
  }

  Future _fetchList() async {
    var group = await widget.noteRepository.getgroups();
    var user = await widget.userRepository.getusers();
    setState(() {
      groups = group;
      users = user;
    });
  }

  Widget build(BuildContext context) {
    _onSubmit() {
      BlocProvider.of<UserBloc>(context).add(
        FormSubmitGroup(
          usercode: selectedUser.usercode,
          groupcode: selectedGroup.groupcode,
        ),
      );
    }

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is UserSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(58.0),
            child: Form(
              child: Column(
                children: [
                  DropdownButtonFormField<User>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    value: selectedUser,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    hint: Text('Selected User'),
                    style: TextStyle(color: Colors.black),
                    onChanged: (newValue) {
                      setState(() {
                        selectedUser = newValue;
                      });
                    },
                    items: users?.map((User user) {
                          return DropdownMenuItem<User>(
                            value: user,
                            child: Text(user.name),
                          );
                        })?.toList() ??
                        [],
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<Group>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    value: selectedGroup,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    hint: Text('Selected Group'),
                    style: TextStyle(color: Colors.black),
                    onChanged: (newValue) {
                      setState(() {
                        selectedGroup = newValue;
                      });
                    },
                    items: groups?.map((Group group) {
                          return DropdownMenuItem<Group>(
                            value: group,
                            child: Text(group.name),
                          );
                        })?.toList() ??
                        [],
                  ),
                  RaisedButton(
                    onPressed: _onSubmit, color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // onPressed: null,
                    child: Text('Submit Note'),
                  ),
                  Container(
                    child: state is UserLoading ? CircularProgressIndicator() : null,
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
