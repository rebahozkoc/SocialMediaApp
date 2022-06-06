import 'package:flutter/material.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/welcome/view/goodby_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings2 extends StatelessWidget {
  const Settings2({Key? key}) : super(key: key);

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
            const ListItemWithSwitch(
                "Private Account", "People will seek permission to follow you"),
            const ListItemWithSwitch(
                "Allow Saving", "People can save your posts to their profile"),
            _ArrowItemState("Block List"),
            _ArrowItemState("Sign Out"),
            _ArrowItemState("Delete Account"),
          ],
        ),
      );
}

class ListItemWithSwitch extends StatefulWidget {
  final String text;
  final String text2;
  const ListItemWithSwitch(this.text, this.text2, {Key? key}) : super(key: key);

  @override
  State<ListItemWithSwitch> createState() => _ListItemWithSwitchState();
}

class _ListItemWithSwitchState extends State<ListItemWithSwitch> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.text, style: kHeader4TextStyle),
              Text(widget.text2, style: kbody2TextStyle),
            ],
          ),
          FlutterSwitch(
              activeColor: state
                  ? Colors.white.withOpacity(1)
                  : Colors.white.withOpacity(0.6),
              toggleColor: AppColors.primary,
              width: 70.0,
              height: 30.0,
              valueFontSize: 25.0,
              toggleSize: 25.0,
              value: state,
              borderRadius: 30.0,
              padding: 5.0,
              switchBorder: Border.all(color: AppColors.primary),
              onToggle: (val) {
                setState(() {
                  state = !state;
                });
              })
        ],
      ),
    );
  }
}

class _ArrowItemState extends StatelessWidget {
  final Authentication _auth = Authentication();
  bool state = true;
  String te1 = "";
  late SharedPreferences prefs;
  _ArrowItemState(t1) {
    te1 = t1;
  }
  void blockList(BuildContext context) {
    NavigationService.instance.navigateToPage(path: NavigationConstants.DELETE);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeleteAccount()),
    );
  }

  void signOut(BuildContext context) async {
    _auth.signOut();
    prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.WELCOME);
  }

  void deleteAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeleteAccount()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [
        TextButton( onPressed: () {
            te1 == "Block List"
                ? blockList(context)
                : te1 == "Sign Out"
                    ? signOut(context)
                    : deleteAccount(context);
          }, 
          child: Row(
            children: [
              Text(te1, style: kHeader4TextStyle),
              Icon((te1 == "Sign Out") ? Icons.logout_outlined : Icons.chevron_right)

          ],))
        
        //IconButton(
          //icon: te1 == "Sign Out"
            //  ? const Icon(Icons.logout_outlined)
        //    /7  : const Icon(Icons.chevron_right),
          //iconSize: 30,
          
        //),
      ]),
    );
  }
}
