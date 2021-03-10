import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendToDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Select Photo'),
      onPressed: () {
        Firestore.instance.collection('posts').add({
          'weight': 222,
          'submission_date': DateTime.parse('2020-01-31')
        });
        // getImage();
      }
    );
  }
}