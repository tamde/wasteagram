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
              inputFieldQuantity('quantity'),
              sendToFirestore(context)
            ]
          )
        )
      );
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

  Widget sendToFirestore(BuildContext context){
    final ExtractorNewPost args = ModalRoute.of(context).settings.arguments;
    return RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()){
          _formKey.currentState.save();
          StorageReference storageReference =
          // give name of the picture the date and time it was taken
            FirebaseStorage.instance.ref().child(getDate());
          StorageUploadTask uploadTask = storageReference.putFile(args.image);
          await uploadTask.onComplete;
          final url = await storageReference.getDownloadURL();
          print(url);
          Firestore.instance.collection('posts').add({
            'quantity': postEntryField.quantity,
            'date': DateTime.parse(getDate()),
            'imageURL': url
          });
          Navigator.pop(context);
        }
      },
      child: Text('Save'),
    );
  }

  Widget inputFieldQuantity(labelText){
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText
      ),
      keyboardType: TextInputType.number,
      onSaved:(value){
        postEntryField.quantity = value;
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