import 'package:flutter/material.dart';
import 'dart:io';

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
  @override
  Widget build(BuildContext context) {
    final ExtractorNewPost args = ModalRoute.of(context).settings.arguments;
    if (args.image == null) {
      return CircularProgressIndicator();
    } else{
        return Container(
        child: Center(
          child: Column(
            children: [
              Image.file(args.image),
              SizedBox(height: 40),
            ],
          ),
        )
      );
    }
  } 
}