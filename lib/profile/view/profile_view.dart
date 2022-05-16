import 'package:flutter/material.dart';
import 'dart:math';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Profile"),
        centerTitle: true,
        actions: <Widget>[
    IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Edit Profile',
          onPressed: () {
            debugPrint("Settings");
          },
        ),
  ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: Dimen.regularParentPadding,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      foregroundImage:
                          NetworkImage("https://picsum.photos/400"),
                    ),
                    const Spacer(),
                    Padding(
                      padding: Dimen.regularParentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rebah Özkoç",
                            style: kHeader2TextStyle,
                          ),
                          Text(
                            "@rebahozkoc",
                            style: kbody1TextStyle,
                          )
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Padding(
                padding: Dimen.regularParentPadding,
                child: Column(
                  children: [
                    Text("About", style: kHeader4TextStyle),
                    Text(
                        "This is about me description and it can be quite long.",
                        style: kbody1TextStyle)
                  ],
                ),
              ),
              Padding(
                padding: Dimen.regularParentPaddingLR,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () =>
                              Scrollable.ensureVisible(dataKey.currentContext!),
                          child: const ProfileCount("Moments", 11)),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              pushNewScreenWithRouteSettings(
                                context,
                                screen: const Followers(),
                                settings: const RouteSettings(
                                    name: Followers.routeName),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: const ProfileCount("Followers", 09))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              pushNewScreenWithRouteSettings(
                                context,
                                screen: const Following(),
                                settings: const RouteSettings(
                                    name: Following.routeName),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: const ProfileCount("Following", 01)))
                  ],
                ),
              ),
              GridView.builder(
                key: dataKey,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: 100,
                itemBuilder: (context, index) {
                  return const MiniPost("https://picsum.photos/400");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCount extends StatelessWidget {
  final String text;
  final int value;

  const ProfileCount(
    this.text,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Dimen.regularParentPadding,
        child: Column(
          children: [
            Text(
              value.toString(),
              style: kHeader3TextStyle,
            ),
            Text(
              text,
              style: kbody2TextStyle,
            )
          ],
        ),
      ),
    );
  }
}
