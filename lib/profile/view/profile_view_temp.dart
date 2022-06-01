import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/settings/view/settings_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  final dataKey = GlobalKey();
  late TabController _controller;
  late List miniPostList;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Your Profile"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              debugPrint("Edit Profile");
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: const Settings2(),
                settings: const RouteSettings(name: Settings2.routeName),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
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
                child: profileMainButtonRow(context),
              ),
              TabBar(
                controller: _controller,
                tabs: const [
                  Tab(
                      icon: Icon(Icons.photo_library_rounded,
                          color: AppColors.primary)),
                  Tab(icon: Icon(Icons.telegram, color: AppColors.primary)),
                ],
              ),
              SizedBox(
                height: 800.0,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    mediaPostGrid(),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text(
                            'Latitude: 48.09342\nLongitude: 11.23403'),
                        trailing: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row profileMainButtonRow(BuildContext context) {
    return Row(
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
                    settings: const RouteSettings(name: Followers.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: const ProfileCount("Followers", 09))),
        Expanded(
            child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: const Following(),
                    settings: const RouteSettings(name: Following.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: const ProfileCount("Following", 01)))
      ],
    );
  }

  GridView mediaPostGrid() {
    return GridView.builder(
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



/*

                  const TabBar(
                    
                    tabs: [
                      Tab(icon: Icon(Icons.photo_library_rounded, color: AppColors.primary)),
                      Tab(icon: Icon(Icons.telegram, color: AppColors.primary)),
                    ],
                    
                  ),









DefaultTabController(
                
                length: 2,
                child: Column(
                  children: [
                  const TabBar(
                    
                    tabs: [
                      Tab(icon: Icon(Icons.photo_library_rounded, color: AppColors.primary)),
                      Tab(icon: Icon(Icons.telegram, color: AppColors.primary)),
                    ],
                    
                  ),
                  Expanded(
                    flex: 2,
                    child: TabBarView(
                      
                      children: [
                        mediaPostGrid(),
                        Icon(Icons.directions_transit),
                      ],
                    ),
                  ),
                ]),
              ),
                  */