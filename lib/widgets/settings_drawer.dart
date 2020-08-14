import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';

class SettingsDrawer extends StatefulWidget {
  final void Function() updateTheme;
  SettingsDrawer({this.updateTheme});

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.findAncestorStateOfType<MyAppState>();

    return Drawer(
        child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
      //verticalDirection: VerticalDirection.down,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 80.0,
            child: DrawerHeader(
              child: Text("Settings"),
            )),
        Text('Dark Mode:'),
        Switch(
            value: appState.getDarkMode,
            onChanged: (value) {
              appState.changeMode(!value);
            })
      ],
    ));
  }
}
