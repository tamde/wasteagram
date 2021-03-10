import 'dart:io';

class Extractor{
  final String title;
  final String body;
  final String rating;
  final String documentId;
  final File image;


  Extractor({this.title, this.body, this.rating, this.documentId, this.image});
}