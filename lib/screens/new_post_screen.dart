import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/widgets/settings_drawer_widget.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = '/newPost';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  // Location information
  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

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
      'wasted': wasted,
      'lat': locationData.latitude,
      'long': locationData.longitude
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // get file from route argument
    final File data = ModalRoute.of(context).settings.arguments;
    var image = Center(
            child: Image.file(
          data,
          fit: BoxFit.scaleDown,
        )) ??
        Text("Error.");
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
