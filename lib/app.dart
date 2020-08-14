import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart';
import 'screens/new_post_screen.dart';
//import 'models/post.dart';

class MyApp extends StatefulWidget {
  static final routes = {
    PostListScreen.routeName: (context) => PostListScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen()
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool darkMode = false;
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
