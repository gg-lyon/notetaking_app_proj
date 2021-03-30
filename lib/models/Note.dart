

class Note {
  String id;
  String title;
  String content;
  DateTime dateTime;

  static Map<String, dynamic> toMap(Note note) {
    return {
      "title": note.title,
      "content": note.content,
      "dateTime": note.dateTime
    };
  }

  static Note fromMap(Map<String, dynamic>map, String id ) {  //dynamic means anything in dart
    Note note = Note();
    note.title = map["title"];
    note.content = map["content"];
    note.id = id;

    return note;
    //note.dateTime = map["dateTime"];
  }
}