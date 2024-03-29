import 'package:flutter/material.dart';
import 'package:jotter/models/note.dart';
import 'package:jotter/screens/home_screen.dart';
import 'package:jotter/screens/note.dart';

class Viewscreen extends StatefulWidget {
  final Note note;
  const Viewscreen({Key? key, required this.note}) : super(key: key);

  @override
  _ViewscreenState createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  String titleText = '';
  String descriptionText = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  submit(context) async{}
  @override
  Widget build(BuildContext context) {
    print('note from previews screen >> ${widget.note.title}');
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              const SizedBox(height: 50),
              TextFormField(
                initialValue: widget.note.title,
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
                initialValue: widget.note.description,
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

              const SizedBox(height: 30),
              MaterialButton(
                color: Colors.black87,
                height: 50, minWidth:20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
                onPressed:  () {
                  loading ? null :  submit(context);
                  // Provider.of<Notesperation>(context, listen: false).addNewNote(titleText,descriptionText);
                },
                child:  loading ? const CircularProgressIndicator(color: Colors.white) : const Text(
                  'Update note',
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
       appBar: AppBar(
         backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () { Navigator.pop(context,
            MaterialPageRoute(builder: (context) => const Homescreen())
        );
        },
             child: const Text('Cancel', style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),
           ),
          ),
           actions: <Widget>[
          Padding(
           padding: const EdgeInsets.only(right: 20.0), child: GestureDetector(
            onTap: () {},
            child: const Text('Save', style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),
          ),
          ),
        ),
      ],
       ),
    );
  }
}
