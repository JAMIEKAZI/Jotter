import 'package:flutter/material.dart';
import 'note.dart';


class Notesoperation extends ChangeNotifier{
  final List<Note> _notes = <Note>[];

  List <Note> get getNotes {
    return  _notes;
  }

  Notesoperation(){
    addNewNote('First Note', 'First Note Description');
  }
  void addNewNote(String title, String description) {
    Note note = Note(title, description);
    _notes.add(note);
    notifyListeners();
  }
}
Future updateNote(String title, String description) async {
}
