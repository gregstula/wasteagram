import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasteagram/screens/post_list_screen.dart';
import 'package:wasteagram/widgets/settings_drawer_widget.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = '/newPost';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  int wasted = 0;

  // uploads image to firebase prepending timestamp and getting the URL
  Future uploadToFireBase(File data) async {
    var storageReference = FirebaseStorage.instance.ref().child(data.path);
    StorageUploadTask uploadTask = storageReference.putFile(data);
    await uploadTask.onComplete;
    String imageURL = await storageReference.getDownloadURL();
    Firestore.instance.collection('posts').add({
      // convert to server timestamp format
      'date': Timestamp.fromDate(DateTime.now()),
      'imageURL': imageURL,
      'wasted': wasted
    });
    Navigator.pushReplacementNamed(context, PostListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // get file from route argument
    final File data = ModalRoute.of(context).settings.arguments;
    var image = Center(child: Image.file(data)) ?? Text("Error.");
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
          // Upload to firebase
          onPressed: () async {
            await uploadToFireBase(data);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
