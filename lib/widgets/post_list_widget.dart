import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/post_screen.dart';
import 'package:wasteagram/models/post.dart';

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
                  final post = snapshot.data.documents[index];
                  // format date to nice string
                  final date = DateFormat.yMMMMd('en_US')
                      .add_jm()
                      .format((post['date'].toDate()));
                  return ListTile(
                    trailing: Text(
                      post['wasted'].toString(),
                      style: Theme.of(content).textTheme.headline5,
                    ),
                    title: Text(date),
                    subtitle: Text(post['imageURL']),
                    onTap: () {
                      Navigator.pushNamed(context, PostScreen.routeName,
                          arguments: new Post(
                              date: date,
                              imageURL: post['imageURL'],
                              wasted: post['wasted']));
                    },
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
