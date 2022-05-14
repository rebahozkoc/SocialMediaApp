import 'package:flutter/material.dart';
import 'dart:math';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: Dimen.regularParentPadding,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    foregroundImage: NetworkImage("https://picsum.photos/400"),
                  ),
                  const Spacer(),
                  Padding(
                    padding: Dimen.regularParentPadding,
                    child: Text("Rebah Özkoç",
                    style: kHeader2TextStyle,),
                  ),
                  const Spacer()
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: Dimen.regularParentPaddingLR,
              child: Column(
                children: [
                  Text("About", style: kHeader4TextStyle),
                  Text("This is about me description and it can be quite long.", style: kbody1TextStyle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

