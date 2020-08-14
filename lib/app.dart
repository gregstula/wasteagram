import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'models/post.dart';

class MyApp extends StatefulWidget {
  static final routes = {
    '/': (context) => ListScreen(),
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool darkMode = false;
  bool get getDarkMode => darkMode;
  List<Post> posts = [Post(date: "January", photo: "www.test.com", items: 3)];

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
