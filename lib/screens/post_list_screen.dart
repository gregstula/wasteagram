import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/settings_drawer_widget.dart';
import 'package:wasteagram/widgets/post_list_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'dart:io';

class PostListScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile.path);
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Posts')),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              _openDrawer();
            },
          )
        ],
      ),
      body: PostList(),
      endDrawer: SettingsDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getImage();
          Navigator.pushNamed(context, NewPostScreen.routeName,
              arguments: image);
        },
        tooltip: 'Pick Image',
        child: Center(child: Icon(Icons.add_a_photo)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
