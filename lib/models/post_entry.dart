import 'dart:io';

class PostEntry{
  int quantity;
  String imageURL;
  double latitude;
  double longitude;
  DateTime date;

  PostEntry({this.quantity, this.imageURL, this.date, this.latitude, this.longitude});
}