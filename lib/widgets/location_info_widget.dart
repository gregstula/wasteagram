import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  LocationInfo({this.lat, this.long});
  final double lat;
  final double long;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('($lat, $long)',
            style: Theme.of(context).textTheme.headline5));
  }
}
