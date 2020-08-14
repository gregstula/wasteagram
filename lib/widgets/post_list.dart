import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.findAncestorStateOfType<MyAppState>();
    int listSize = appState.posts.length;
    if (listSize != 0) {
      return ListView.builder(
        itemCount: listSize,
        itemBuilder: (context, index) {
          final post = appState.posts[index];
          return ListTile(
              title: Text(post.date),
              subtitle: Text(post.items.toString()),
              onLongPress: () {
                //Navigator.pushNamed(context, '/', arguments: post);
              });
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
