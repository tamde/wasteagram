import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:wasteagram/models/post_entry.dart';

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
        body: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:Image.file(
                  args.image,
                  height: 250,)
              ),
              Form(
                key: _formKey,
                child: inputFieldBody('weight')
              ),
              RaisedButton(
                onPressed: () async {
                  StorageReference storageReference =
                    FirebaseStorage.instance.ref().child('example2.jpg');
                  StorageUploadTask uploadTask = storageReference.putFile(args.image);
                  await uploadTask.onComplete;
                  final url = await storageReference.getDownloadURL();
                  print(url);
                  Firestore.instance.collection('posts').add({
                    'weight': 222,
                    'submission_date': DateTime.parse('2020-01-31')
                  });
                  Navigator.pop(context);
                },
                child: Text('Save'),

              )
            ],
          ),
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