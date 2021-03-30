import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_taking_app/models/Note.dart';

Future<FirebaseApp> initDb() {
  return Firebase.initializeApp();
}

CollectionReference ref = FirebaseFirestore.instance.collection('notes');


void recordDocument(Note note) {
  if(note.id == null) {
    ref.doc().set(Note.toMap(note));
  }
  else {
    ref.doc(note.id).set(Note.toMap(note));
  }
}

Future<Note> getDocument(String id) async {
  DocumentSnapshot snapshot = await ref.doc(id).get();
  return Note.fromMap(snapshot.data(), snapshot.id);
}

Future<List<Note>> getAllDocuments() async{
  QuerySnapshot docs = await ref.get();
  if(docs.size == 0) return [];
  return docs.docs.map<Note>((note) => Note.fromMap(note.data(), note.id)).toList();
}

Future<Note> deleteDocument(String id) {
  return ref.doc(id).delete();
}

Stream<QuerySnapshot> getDocCollection() {
  return ref.snapshots();
}