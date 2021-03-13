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
  final String latitude;
  final String longitude;


  ExtractorDetails({this.quantity, this.body, this.date, this.documentId, this.imageURL, this.latitude, this.longitude});
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
              Text(args.quantity + ' items')
            ]),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Text('latitude: ' + args.latitude),
                Text('longitude: ' + args.longitude)
              ])
            ) 
          ]
        )
      )
    );
  }
}