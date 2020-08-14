import 'package:intl/intl.dart';

class Post {
  Post({this.imageURL, this.date, this.wasted});
  Post.fromDynamic(dynamic post) {
    this.imageURL = post['imageURL'];
    this.date =
        DateFormat.yMMMMd('en_US').add_jm().format((post['date'].toDate()));
    this.wasted = post['wasted'];
    this.lat = post['lat'];
    this.long = post['long'];
  }

  String imageURL;
  String date;
  int wasted;
  double lat = 0.0;
  double long = 0.0;
}
