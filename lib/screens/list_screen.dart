import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/settings_drawer.dart';
import 'package:wasteagram/widgets/post_list.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'new_entry');
          },
          child: Icon(Icons.add),
        ));
  }
}
