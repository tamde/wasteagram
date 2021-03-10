import 'package:flutter/material.dart';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
// import 'package:wasteagram/models/extractor.dart';


class ExtractorDetails{
  final String title;
  final String body;
  final String rating;
  final String documentId;
  final File image;


  ExtractorDetails({this.title, this.body, this.rating, this.documentId, this.image});
}

class Details extends StatelessWidget {

  static const routeName = '/detail_screen';
  

  @override
  Widget build(BuildContext context) {
    final ExtractorDetails args = ModalRoute.of(context).settings.arguments;
    return ScaffoldWidget(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  args.body,
                  style: TextStyle(
                    fontSize: 72,
                  )
                )
              ],
            ),
            Row(
              children: [
                Text(
                  args.body,
                  style: TextStyle(
                    fontSize: 72,
                  )
                )
              ],
            ),
          ]
        )
      )
    );
  }
}