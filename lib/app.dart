import 'package:flutter/material.dart';
import 'package:wasteagram/screens/post_screen.dart';
import 'screens/post_list_screen.dart';
import 'screens/new_post_screen.dart';
//import 'models/post.dart';

class MyApp extends StatefulWidget {
  static final routes = {
    PostListScreen.routeName: (context) => PostListScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    PostScreen.routeName: (context) => PostScreen()
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool darkMode = true;
  bool get getDarkMode => darkMode;

  void changeMode(bool value) {
    setState(() {
      darkMode = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDarkMode ? ThemeData.dark() : ThemeData.light(),
      routes: MyApp.routes,
    );
  }
}
