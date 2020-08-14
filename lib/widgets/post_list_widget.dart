import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (content, index) {
                  final dynamicData = snapshot.data.documents[index];
                  // format date to nice string
                  final post = Post.fromDynamic(dynamicData);
                  return ListTile(
                    trailing: Text(
                      post.wasted.toString(),
                      style: Theme.of(content).textTheme.headline5,
                    ),
                    title: Text(post.date),
                    onTap: () {
                      Navigator.pushNamed(context, PostScreen.routeName,
                          arguments: post);
                    },
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
