import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/controller/FirebaseController.dart';
import 'package:note_taking_app/screens/NoteEdit.dart';
import 'package:note_taking_app/screens/NotesList.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notetaking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Notes List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        NoteEditScreen.route: (context)=>NoteEditScreen()
      },
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NoteEditScreen())); //change to noteAdd later
          },
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<Object>(
            future: initDb(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Center(
                  child: Column(
                    children: [
                      NotesListScreen()
                    ],
                  ));
            }
        ),
      ),
    );
  }
}