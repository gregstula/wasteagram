import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (content, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (content, index) {
                  var post = snapshot.data.documents[index];
                  return ListTile(
                    trailing: Text(
                      post['wasted'].toString(),
                      style: Theme.of(content).textTheme.headline5,
                    ),
                    title: Text(DateFormat.yMMMMd('en_US')
                        .add_jm()
                        .format((post['date'].toDate()))),
                    subtitle: Text(post['image']),
                    onTap: () {},
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
