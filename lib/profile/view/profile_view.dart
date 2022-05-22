import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/profile/view/edit_profile.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/settings/view/settings_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';

import '../../post/model/post_model.dart';
import '../../post/view/post_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  final dataKey = GlobalKey();
  late TabController _controller;
  final List<String> miniPostList = [
    "https://picsum.photos/600",
    "https://picsum.photos/501",
    "https://picsum.photos/601",
    "https://picsum.photos/502",
    "https://picsum.photos/603",
    "https://picsum.photos/404",
    "https://picsum.photos/605",
    "https://picsum.photos/706",
    "https://picsum.photos/607",
    "https://picsum.photos/808",
    "https://picsum.photos/609",
    "https://picsum.photos/520",
    "https://picsum.photos/612",
    "https://picsum.photos/523",
    "https://picsum.photos/646",
    "https://picsum.photos/343",
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  Row _settingsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: const EditProfileView(),
                settings: const RouteSettings(name: EditProfileView.routeName),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: const Settings(),
                settings: const RouteSettings(name: Settings.routeName),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var infos = [
      _settingsRow(),
      Padding(
        padding: Dimen.regularParentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 42,
              foregroundImage: NetworkImage("https://picsum.photos/400"),
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
            const Spacer(),
          ],
        ),
      ),
      Padding(
        padding: Dimen.regularParentPadding,
        child: Column(
          children: [
            Text("About", style: kHeader4TextStyle),
            Text("This is about me description and it can be quite long.",
                style: kbody1TextStyle)
          ],
        ),
      ),
      Padding(
        padding: Dimen.regularParentPaddingLR,
        child: profileMainButtonRow(context),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                SliverList(
                  delegate: SliverChildListDelegate(infos),
                ),
              ]),
          body: Column(
            children: [
              TabBar(
                controller: _controller,
                tabs: const [
                  Tab(
                      icon: Icon(Icons.photo_library_rounded,
                          color: AppColors.primary)),
                  Tab(icon: Icon(Icons.text_snippet, color: AppColors.primary)),
                  Tab(icon: Icon(Icons.bookmark, color: AppColors.primary)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    GridView.builder(
                      key: dataKey,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                      ),
                      itemCount: miniPostList.length,
                      itemBuilder: (context, index) {
                        return MiniPost(miniPostList[index]);
                      },
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 1217,
                            commentCount: 32,
                            contentCount: 0,
                            postText:
                                "When you thought you already had all the bad luck of the world in Monaco and you lose the brakes into rascasse with one of the most iconic historical Ferrari Formula 1 car. 🙃🔫",
                            contents: [],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 1217,
                            commentCount: 32,
                            contentCount: 0,
                            postText:
                                "When you thought you already had all the bad luck of the world in Monaco and you lose the brakes into rascasse with one of the most iconic historical Ferrari Formula 1 car. 🙃🔫",
                            contents: [],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 1217,
                            commentCount: 32,
                            contentCount: 0,
                            postText:
                                "When you thought you already had all the bad luck of the world in Monaco and you lose the brakes into rascasse with one of the most iconic historical Ferrari Formula 1 car. 🙃🔫",
                            contents: [],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 1217,
                            commentCount: 32,
                            contentCount: 0,
                            postText:
                                "When you thought you already had all the bad luck of the world in Monaco and you lose the brakes into rascasse with one of the most iconic historical Ferrari Formula 1 car. 🙃🔫",
                            contents: [],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-22T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 58100000,
                            commentCount: 58,
                            contentCount: 1,
                            postText:
                                "Red Bull’un dünkü arızalarla ilgili ilk tahmini yakıt pompasıydı.\n\nFarklı bir sorun olabileceğini düşünüyorum. Yarınki yazımda..",
                            contents: [
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOZ58QxXEAYvEsF?format=jpg&name=medium"),
                            ],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-22T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 58100000,
                            commentCount: 58,
                            contentCount: 4,
                            postText:
                                "Red Bull’un dünkü arızalarla ilgili ilk tahmini yakıt pompasıydı.\n\nFarklı bir sorun olabileceğini düşünüyorum. Yarınki yazımda..",
                            contents: [
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOZ58QxXEAYvEsF?format=jpg&name=medium"),
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOZ58QxXEAYvEsF?format=jpg&name=medium"),
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOZ58QxXEAYvEsF?format=jpg&name=medium"),
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOZ58QxXEAYvEsF?format=jpg&name=medium"),
                            ],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 1217,
                            commentCount: 32,
                            contentCount: 0,
                            postText:
                                "When you thought you already had all the bad luck of the world in Monaco and you lose the brakes into rascasse with one of the most iconic historical Ferrari Formula 1 car. 🙃🔫",
                            contents: [],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2022-03-21T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 44567,
                            commentCount: 11518,
                            contentCount: 2,
                            postText: "10 minutes to go.",
                            contents: [
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOTQrLJXMAEYEDn?format=jpg&name=large"),
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOTQrLKXIAMKbDB?format=jpg&name=large")
                            ],
                          ),
                        ),
                        PostView(
                          postModel: PostModel(
                            name: "Charles Leclerc",
                            date: "2021-03-20T20:18:04.000Z",
                            profileImg:
                                "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                            likeCount: 111111111,
                            commentCount: 583453,
                            contentCount: 1,
                            postText: "This means so much...",
                            contents: [
                              Content(
                                  type: "image",
                                  contentId: "text",
                                  source:
                                      "https://pbs.twimg.com/media/FOYNTX9XwAMy_Wu?format=jpg&name=large"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    )
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
              onPressed: () => {}, child: const ProfileCount("Moments", 11)),
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