import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:jotter/models/note.dart';

class NoteProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Note> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Note> get items => UnmodifiableListView(_items);


  void add(Note item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }


  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}