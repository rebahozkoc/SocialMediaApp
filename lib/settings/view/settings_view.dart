import 'package:flutter/material.dart';
import 'package:sabanci_talks/widgets/person_header_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: _body());
  }

  SingleChildScrollView _body() => SingleChildScrollView(
        child: Column(
          children: [
            ListItemWithSwitch("text")
          ],
        ),
      );
}


class ListItemWithSwitch extends StatefulWidget {
  final String text;
  
  const ListItemWithSwitch(this.text, { Key? key }) : super(key: key);

  @override
  State<ListItemWithSwitch> createState() => _ListItemWithSwitchState();
}

class _ListItemWithSwitchState extends State<ListItemWithSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Text("text"),
         FlutterSwitch(
            width: 125.0,
            height: 55.0,
            valueFontSize: 25.0,
            toggleSize: 45.0,
            value: true,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                //status = val;
              });})
      ],)
    );
  }
}