import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:intl/intl.dart';



class PostLists extends StatefulWidget {
  final darkTheme;
  final toggleTheme;
  final schema;
  PostLists({this.darkTheme, this.toggleTheme, this.schema});
  
  static const routeName = '/list_screen';
  @override
  _PostListsState createState() => _PostListsState();
}

class _PostListsState extends State<PostLists> {

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
            return Column(
              children: [
                listView(context, snapshot),
                selectPicButton(context)
              ]
            );
          } else {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator()
                ),
                selectPicButton(context)
              ],
            );
          }
        }
      )
    );
  }
}

Widget selectPicButton(BuildContext context) {

  File image;
  final picker = ImagePicker();

  Future getImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    return image;
  }

  return RaisedButton(
    child: Text('Select Photo'),
    onPressed: () async {
        var theImage = await getImages();
        Navigator.pushNamed(
        context, 
        NewPost.routeName,
        arguments: ExtractorNewPost(
          image: theImage
        )
      );
    }
  );
}

Widget listView(BuildContext context, snapshot) {
  return Expanded(
    child:  ListView.builder(
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) {
        var post = snapshot.data.documents[index];
        var date = DateFormat.yMMMMEEEEd().format(post['date'].toDate());
        return ListTile(
          leading: Text(post['quantity'].toString()),
          title: Text(date),//Text(post['date'].toString()),
          subtitle: Text(post.documentID),
          onTap: (){
            Navigator.pushNamed(
              context,
              Details.routeName,
              arguments: ExtractorDetails(
                imageURL: post['imageURL'].toString(),
                body: post['quantity'].toString(),
                date: date,
                quantity: post['quantity'].toString()
              )
            );
          },
        );
      }
    )
  );
}