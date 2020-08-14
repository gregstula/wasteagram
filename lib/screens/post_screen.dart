import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/postScreen';
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(post.date)),
        body: Column(children: [
          Image.network(post.imageURL, fit: BoxFit.scaleDown),
          Text(post.wasted.toString(), textAlign: TextAlign.center)
        ]));
  }
}
