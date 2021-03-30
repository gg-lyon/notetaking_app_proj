import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/controller/FirebaseController.dart';
import 'package:note_taking_app/models/Note.dart';
import 'package:note_taking_app/screens/NotesList.dart';

class NoteEditWidget extends StatefulWidget {
  final Note note;

  const NoteEditWidget({Key key, this.note}) : super(key: key);
  @override
  _NoteEditWidgetState createState() => _NoteEditWidgetState();
}

class _NoteEditWidgetState extends State<NoteEditWidget> {
  Note _note;

  @override
  void initState() {
    _note = widget.note ?? Note();  //?? means checking if its null
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: _note.title ?? "");
    TextEditingController contentController = TextEditingController(text: _note.content ?? "");

    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Title"),
          onChanged: (title)=>_note.title = title,),
        TextField(
          controller: contentController,
          decoration: InputDecoration(labelText: "Message", hintText: "Write message here..."),
          onChanged: (content)=>_note.content = content,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            child: Text("Save note"),
            onPressed: (){
              _note.dateTime = DateTime.now();
              recordDocument(_note);
            },),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: Text("Delete note"),
            onPressed: () {
              Navigator.pop(context);
              deleteDocument(_note.id);
            },),
        )
      ],);
  }
}

class NoteEditScreen extends StatelessWidget {
  static const String route = "/NoteEditScreen";

  Note getNoteFromParams(BuildContext context) {
    NoteEditScreenArguments args = ModalRoute.of(context).settings.arguments;
    return args?.note ?? Note();
  }

  @override
  Widget build(BuildContext context) {
    Note note = getNoteFromParams(context);
    return Scaffold(
      appBar: AppBar(title: Text("Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NoteEditWidget(note: note,),
      ),
    );
  }
}

class NoteEditScreenArguments {
  final Note note;

  NoteEditScreenArguments(this.note);
}