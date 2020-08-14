import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/widgets/settings_drawer_widget.dart';
import 'package:wasteagram/widgets/post_list_widget.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = '/newPost';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
//
  @override
  Widget build(BuildContext context) {
    final File data = ModalRoute.of(context).settings.arguments;
    var image = Center(child: Image.file(data)) ?? Text("Error.");
    var wasted = 0;
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Posts')),
      ),
      body: Column(
        children: [
          // image to upload
          image,
          // to enter wasted value
          TextFormField(
              decoration:
                  InputDecoration(hintText: "Wasted", alignLabelWithHint: true),
              keyboardType: TextInputType.number, // numbers only
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
              onChanged: (newValue) => wasted = int.parse(newValue))
        ],
      ),
      endDrawer: SettingsDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Submit Post',
        child: Center(child: Icon(Icons.cloud_upload)),
        onPressed: () {
          Firestore.instance.collection('posts').add({
            // convert to server timestamp format
            'Date': Timestamp.fromDate(DateTime.now()),
            'Items': wasted
          });
          Navigator.pushReplacementNamed(context, ListScreen.routeName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
