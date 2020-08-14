import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/widgets/location_info_widget.dart';

class PostScreen extends StatelessWidget {
  static const routeName = '/postScreen';
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(post.date)),
        body: Column(children: [
          Center(child: Image.network(post.imageURL, fit: BoxFit.scaleDown)),
          Text(
            post.wasted.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          LocationInfo(lat: post.lat, long: post.long)
        ]));
  }
}
