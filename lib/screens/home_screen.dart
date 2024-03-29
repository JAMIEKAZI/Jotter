import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jotter/models/note.dart';
import 'package:jotter/providers/notes_provider.dart';
import 'package:jotter/screens/add_screen.dart';
import 'package:jotter/screens/view_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class Homescreen  extends StatefulWidget {
  const Homescreen ({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomescreenState();
  }
}
class HomescreenState extends State <Homescreen>{
bool loading = false;

List  notes = [];

initState() {
  print('new note');
  fetchNotes();
  super.initState();
}

fetchNotes() async{
  try {
    setState(() {
      loading = true;
    });

    //  Todo add firebase api call
    var url = Uri.parse('https://notepad-cb066-default-rtdb.firebaseio.com/');
    http.Response response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseData = response.body;
    var tempNotes = [];
    if (response.statusCode == 200 && responseData != 'null') {
      print('rest $responseData');
    final Map<String, dynamic> jsonData = json.decode(response.body);
    jsonData.forEach((key, value) {
      tempNotes.insert(0, value);
      print('notes=${notes.length}');
    });
    } else {
    }
    setState(() {
      notes = tempNotes;
      loading = false;
      });


    // Navigator.pop(context);
  } catch (e) {
    print('error $e');
    setState(() {
      loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
        var result = await  Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Addscreen()),
          );
          if (result == true) {
            fetchNotes();
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text ('Jotter', style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold,
        ),
        ),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: loading ? const Center(child: CircularProgressIndicator()):

      RefreshIndicator(
          onRefresh: () async {
            await fetchNotes();
          },
        child:
         Consumer<NoteProvider>(
           builder: (context, cart, child) {
             if(cart.items.isEmpty){
             return  const Center(child: Text('No notes found, tap the button below'));
             }
             return Container(
               padding: const EdgeInsets.all(20),
                 child: ListView.builder(

                   itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return NotesCard(cart.items[index]);
              },
              ));
           }
         )));
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

   NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    print('note $note');
    return Container(
          margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        ),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(
              builder: ((BuildContext context) => Viewscreen(note: note))
          )
          );
          },
          leading: CircleAvatar(child: Text(note.title.substring(0, 1),),),
          title: Text(note.title),
          subtitle: Text(note.description,),
        ),
    );
  }
}


