import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/authentication/authentication.dart';
import 'package:tugerente/models/user_model.dart';

import 'package:tugerente/pages/groups/group_page.dart';

import 'package:tugerente/pages/notes/notes_page_page.dart';
import 'package:tugerente/pages/usergroup/user_group_page.dart';
import 'package:tugerente/repositories/group/group_repository.dart';
import 'package:tugerente/repositories/note/note_repository.dart';
import 'package:tugerente/repositories/user/user_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final noteRepository = NoteRepository();
  String name;
  final groupRepository = GroupRepository();
  User user;
  final userRepository = UserRepository();
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    final data = await userRepository.getuser();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('TU GERENTE'),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
              child: Text('Loggout'),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HOLA QUERIDO: ', style: TextStyle(fontSize: 20, color: Colors.black)),
              Text(user.name,
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                RaisedButton(
                  color: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text('CREAR NOTAS',
                      style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotePage(noteRepository: noteRepository)),
                    );
                  },
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text('CREAR GRUPOS',
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GroupPage(groupRepository: groupRepository)),
                    );
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text('ASIGNAR GRUPOS',
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserGroupPage(noteRepository: noteRepository, userRepository: userRepository)),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
