import 'dart:io';

class Post {
  Post({this.photo, this.date, this.items});

  File photo;
  DateTime date;
  int items;
}
