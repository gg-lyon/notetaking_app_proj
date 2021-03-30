import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/models/Note.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(note?.title ?? "No title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(note?.content ?? "content"),
          ),
          Text(note?.dateTime?.toString() ?? ""),
          Container(height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,)
        ],
      ),
    );
  }
}
