import 'package:flutter/material.dart';
import 'package:jotter/providers/notes_provider.dart';
import 'package:jotter/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteProvider>(
      create: (context) => NoteProvider(),
      child: const MaterialApp(
        home: (Homescreen()),
      ),
    );
  }
}

