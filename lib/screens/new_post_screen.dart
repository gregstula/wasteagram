import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/settings_drawer.dart';
import 'package:wasteagram/widgets/post_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewPostScreen extends StatefulWidget {
  static const routeName = '/newPost';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
//
  @override
  Widget build(BuildContext context) {
    final File arg = ModalRoute.of(context).settings.arguments;
    var image = Center(child: Image.file(arg)) ?? Text("Error.");
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Posts')),
      ),
      body: image,
      endDrawer: SettingsDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Submit Post',
        child: Center(child: Icon(Icons.cloud_upload)),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
