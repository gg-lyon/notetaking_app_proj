
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/controller/FirebaseController.dart';
import 'package:note_taking_app/models/Note.dart';
import 'package:note_taking_app/screens/NoteEdit.dart';
import 'package:note_taking_app/widgets/NoteWidget.dart';

class NotesListWidget extends StatelessWidget {
  final List<Note> notesList;


  const NotesListWidget({Key key, this.notesList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(notesList == null || notesList.isEmpty) {
      return Center(child: Text("Write a note using the + button"),);
    }
    return Column(
      children: notesList.map<Widget>((note) => GestureDetector(
          onTap: () {
            // NoteEditScreenArguments args = ModalRoute.of(context).settings.arguments;
            //     return args?.note ?? Note();

            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NoteEditScreen(),
                settings: RouteSettings(arguments: NoteEditScreenArguments(note))));
          },
          child: NoteWidget(note: note,))).toList(),
    );
  }
}

class NotesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<Note>>(
        future: getAllDocuments(),
        builder: (context,  AsyncSnapshot<List<Note>> snapshot) {

          if (snapshot.hasData) {
            return NotesListWidget(notesList: snapshot.data,);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });

  }
}