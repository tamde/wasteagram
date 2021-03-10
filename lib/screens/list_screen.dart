import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/components/scaffold_widget.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';


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

  File image;
  final picker = ImagePicker();

  void getImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    // StorageReference storageReference =
    //   FirebaseStorage.instance.ref().child('example2.jpg');
    // StorageUploadTask uploadTask = storageReference.putFile(image);
    // await uploadTask.onComplete;
    // final url = await storageReference.getDownloadURL();
    // print(url);

  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child:  ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data.documents[index];
                      return ListTile(
                        leading: Text(post['weight'].toString()),
                        title: Text('Post Title'),
                        subtitle: Text(post.documentID),
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            Details.routeName,
                            arguments: ExtractorDetails(
                              title: post.documentID.toString(),
                              body: post['weight'].toString()
                              
                            )
                          );
                        },
                      );
                    }
                  )
                ),
                RaisedButton(
                  child: Text('Select Photo'),
                  onPressed: () {
                    // Firestore.instance.collection('posts').add({
                    //   'weight': 222,
                    //   'submission_date': DateTime.parse('2020-01-31')
                    // });
                    getImages();
                    Navigator.pushNamed(
                      context, 
                      NewPost.routeName,
                      arguments: ExtractorNewPost(
                        image: image
                      )
                    );
                  }
                )
              ]
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      )    
    );
  }
}

Widget listView() {
  
}