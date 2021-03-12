import 'package:flutter/material.dart';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
// import 'package:wasteagram/models/extractor.dart';


class ExtractorDetails{
  final String quantity;
  final String body;
  final String date;
  final String documentId;
  final String imageURL;


  ExtractorDetails({this.quantity, this.body, this.date, this.documentId, this.imageURL});
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(args.date),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(args.imageURL,
                  height: 250,
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(args.quantity)
            ])
          ]
        )
      )
    );
  }
}