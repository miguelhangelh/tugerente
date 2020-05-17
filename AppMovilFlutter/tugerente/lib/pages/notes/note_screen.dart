import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugerente/bloc/notes/notes_bloc.dart';
import 'package:tugerente/models/group_model.dart';
import 'package:tugerente/repositories/note/note_repository.dart';
import 'package:tugerente/utils/utils.dart';

class NoteScreen extends StatefulWidget {
  final NoteRepository noteRepository;

  NoteScreen({Key key, @required this.noteRepository})
      : assert(noteRepository != null),
        super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  Group selectedGroup;
  List<Group> groups;

  @override
  @override
  initState() {
    super.initState();
    _fetchList();
  }

  Future _fetchList() async {
    var data = await widget.noteRepository.getgroups();
    setState(() {
      groups = data;
    });
  }

  Widget build(BuildContext context) {
    _onSubmit() {
      BlocProvider.of<NotesBloc>(context).add(
        FormSubmit(
          title: _titleController.text,
          detail: _detailController.text,
          groupcode: selectedGroup.groupcode,
        ),
      );
    }

    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) {
        if (state is NotesFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is NotesSuccess) {
          mostrarAlerta(context, 'mensaje');
        }
      },
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(58.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      labelText: 'Detail',
                    ),
                    controller: _detailController,
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
                    hint: Text('Select Item'),
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
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: _onSubmit,
                    // onPressed: null,
                    child: Text('Submit Note'),
                  ),
                  Container(
                    child: state is NotesLoading ? CircularProgressIndicator() : null,
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
