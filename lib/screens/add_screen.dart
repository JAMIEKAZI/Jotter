import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jotter/models/note.dart';
import 'package:jotter/models/notesoperation.dart';
import 'package:jotter/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class Addscreen extends StatefulWidget {
  const Addscreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddscreenState();
  }
}
class AddscreenState extends State<Addscreen> {
  String titleText = '';
  String descriptionText = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override


  submit(context) async{
   try {
     if (!_formKey.currentState!.validate()) {
       return;
     }
     _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

     // //  Todo add firebase api call
     // var payload = {'titleText': titleText, 'descriptionText': descriptionText};
     // var url = Uri.parse(
     //     'https://notepad-cb066-default-rtdb.firebaseio.com/');
     // http.Response response = await http.post(url,
     //     body: jsonEncode(payload));
     // print('Response status: ${response.statusCode}');
     // print('Response body: ${response.body}');


     NoteProvider().add(Note(titleText, descriptionText));


     setState(() {
       loading = false;
     });
     _formKey.currentState!.reset();
     displaySnackBar(context, 'Your note has been saved');
     Navigator.pop(context, true);
   } catch (e) {
     print('error $e');
     setState(() {
       loading = false;
     });
     displaySnackBar(context, '$e');
   }
  }

  displaySnackBar(context, title) {
    var snackBar = SnackBar(content: Text('$title'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget build (BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text ('Jotter', style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            const SizedBox(height: 50),
           TextFormField(

             onSaved: (value ) {
               titleText = value as String;
             },
             validator: (value) {
               if(value!.isEmpty) {
                 return "Title is required";
               }
             },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black45),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: 'Title',
                  labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                hintText: 'Enter Title',
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
                ),


            const SizedBox(height: 25),
            TextFormField(
              onSaved: (value ) {
                descriptionText = value as String;
              },
              validator: (value) {
                if(value!.isEmpty) {
                  return "Description is required";
                }
              },
              maxLines: 5,
               keyboardType: TextInputType.multiline,
                decoration: InputDecoration(

                  filled: true,

                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),

                  ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black45),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Enter description',
                    labelText: 'Description',
                    labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    hintStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SizedBox(height: 25),
              MaterialButton(
              color: Colors.black87,
              height: 50, minWidth:20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              onPressed:  () {
                loading ? null :  submit(context);
                // Provider.of<Notesperation>(context, listen: false).addNewNote(titleText,descriptionText);
              },
                child:  loading ? const CircularProgressIndicator(color: Colors.white) : const Text(
                  'Add note',
                   style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                  ),
                ),
          ],
        ),
      ),
    ),
    );
  }
}
