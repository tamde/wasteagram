import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class SendToFS{
  // final quantity;
  // final date;
  // final imageURL;
  // final latitude;
  // final longitude;
  
  // SendToFS({this.quantity, this.date, this.imageURL, this.latitude, this.longitude});


  send(quantity, date, imageURL, latitude, longitude){
    Firestore.instance.collection('posts').add({
    'quantity': quantity,
    'date': date,
    'imageURL': imageURL,
    'latitude': latitude,
    'longitude': longitude
    });
  }
}