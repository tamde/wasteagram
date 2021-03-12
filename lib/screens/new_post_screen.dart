import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:wasteagram/models/post_entry.dart';
import 'package:intl/intl.dart';


class ExtractorNewPost{
  final File image;

  ExtractorNewPost({this.image});
}

class NewPost extends StatefulWidget {

  static const routeName = '/new_post_screen';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  getDate(){
    var date = DateTime.now();
    return date.toString();
  }

  final _formKey = GlobalKey<FormState>();
  final postEntryField = PostEntry();

  @override
  Widget build(BuildContext context) {
    final ExtractorNewPost args = ModalRoute.of(context).settings.arguments;
    if (args.image == null) {
      return CircularProgressIndicator();
    } else {
      return ScaffoldWidget(
        title: 'Wasteagram',
        body: Form(
          key: _formKey, 
          child: Column(
            children: [
              imageAlign(context),
              inputFieldBody('weight'),
              button(context)
            ]
          )
        )
      );
        
      
      // return ScaffoldWidget(
      //   title: 'Wasteagram',
      //   body: Container(
      //     child: Align(
      //       alignment: Alignment.topCenter,
      //       child: Image.file(args.image),
      //     )
      //   )
      // );
        
    }
  } 

  Widget imageAlign(BuildContext context){
    final ExtractorNewPost args = ModalRoute.of(context).settings.arguments;
    return Align(
      alignment: Alignment.topCenter,
      child:Image.file(
        args.image,
        height: 250,)
    );
  }

  Widget button(BuildContext context){
    final ExtractorNewPost args = ModalRoute.of(context).settings.arguments;
    return RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()){
          _formKey.currentState.save();
          StorageReference storageReference =
            FirebaseStorage.instance.ref().child('example3.jpg');
          StorageUploadTask uploadTask = storageReference.putFile(args.image);
          await uploadTask.onComplete;
          final url = await storageReference.getDownloadURL();
          print(url);
          Firestore.instance.collection('posts').add({
            'weight': 223,
            'submission_date': DateTime.parse(getDate())
          });
          Navigator.pop(context);
        }
      },
      child: Text('Save'),
    );
  }

  Widget inputFieldBody(labelText){
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText
      ),
      keyboardType: TextInputType.number,
      onSaved:(value){
        postEntryField.weight = value;
      },
      validator: (value) {
        if (value.isEmpty){
          return 'Please enter some text';
        }
        return null;
      }
    );
  }
}