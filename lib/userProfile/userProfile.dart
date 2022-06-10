import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

//import 'package:sabanci_talks/firestore_classes/user/user.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/post/view/single_post.dart';

import 'package:sabanci_talks/profile/view/edit_profile.dart';
import 'package:sabanci_talks/profile/view/followers_view.dart';
import 'package:sabanci_talks/profile/view/following_view.dart';
import 'package:sabanci_talks/settings/view/settings_view.dart';
import 'package:sabanci_talks/util/analytics.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/mini_post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../post/model/post_model.dart';
import '../../post/view/post_view.dart';
import "package:sabanci_talks/firestore_classes/firestore_main/firestore.dart";

class UserProfileView extends StatefulWidget {
  const UserProfileView(
      {Key? key,
      required this.uid,
      required this.isPrivate,
      required this.isFollowed})
      : super(key: key);
  final String uid;
  final bool isPrivate;
  final bool isFollowed;
  @override
  State<UserProfileView> createState() => _UserProfileView();
  static String routeName = '/UserProfileView';
}

class _UserProfileView extends State<UserProfileView>
    with SingleTickerProviderStateMixin {
  final dataKey = GlobalKey();
  dynamic myUser;
  MyUser? myUserFromJson;
  String? uid;
  dynamic show;
  dynamic posts;
  dynamic followers;
  dynamic followings;
  Firestore f = Firestore();
  dynamic miniPostList;
  dynamic miniTextList;

  Future<void> getUser() async {
    show = await f.getUser(widget.uid);

    posts = await f.getPost(widget.uid);
    followers = await f.getFollowers(widget.uid);
    followings = await f.getFollowings(widget.uid);
    miniPostList = posts != null
        ? posts.where((i) => i[1].pictureUrlArr.length != 0).toList()
        : [];
    miniTextList = posts != null
        ? posts.where((i) => i[1].pictureUrlArr.length == 0).toList()
        : [];
  }

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("User Profile View");
    debugPrint("widget.uid is ${widget.uid}");
    debugPrint("helllooooooo is ${widget.isPrivate}");
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: const BackButton(color: Colors.white),
            ),
            body: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: Dimen.regularParentPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 42,
                                  foregroundImage: NetworkImage(show != null
                                      ? show[1].profilePicture
                                      : "https://picsum.photos/400"),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: Dimen.regularParentPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        show != null ? show[1].fullName : "",
                                        style: kHeader2TextStyle,
                                      ),
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
                                Text(
                                    (show != null)
                                        ? show[1].biography
                                        : "Empty",
                                    style: kbody1TextStyle)
                              ],
                            ),
                          ),
                          Padding(
                            padding: Dimen.regularParentPaddingLR,
                            child: (widget.isPrivate && !widget.isFollowed)
                                ? profileMainButtonRowPrivate(context)
                                : profileMainButtonRow(context),
                          ),
                        ]),
                      ),
                    ]),
                body: (widget.isPrivate && !widget.isFollowed)
                    ? const Icon(
                        IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                        size: 200,
                        color: AppColors.primary,
                      )
                    : Column(
                        children: [
                          TabBar(
                            controller: _controller,
                            tabs: const [
                              Tab(
                                  icon: Icon(Icons.photo_library_rounded,
                                      color: AppColors.primary)),
                              Tab(
                                  icon: Icon(Icons.text_snippet,
                                      color: AppColors.primary)),
                              Tab(
                                  icon: Icon(Icons.bookmark,
                                      color: AppColors.primary)),
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
                                  itemCount: miniPostList != null
                                      ? miniPostList.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        child: MiniPost(miniPostList != null
                                            ? miniPostList[index][1]
                                                .pictureUrlArr[0]
                                            : "https://picsum.photos/600"),
                                        onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SinglePost(
                                                            proUrl: show[1]
                                                                .profilePicture,
                                                            docId: posts[index]
                                                                [0],
                                                            name: show[1]
                                                                .fullName,
                                                            date: posts[index]
                                                                    [1]
                                                                .createdAt)),
                                              )
                                            });
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
        });
  }

  Row profileMainButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
              onPressed: () => {},
              child: ProfileCount("Moments", posts != null ? posts.length : 0)),
        ),
        Expanded(
            child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: Followers(
                        mylist: followers.followers,
                        refresher: () {
                          setState(() {});
                        }),
                    settings: const RouteSettings(name: Followers.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ProfileCount("Followers",
                    followers != null ? followers.followers.length : 0))),
        Expanded(
            child: TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: Following(
                        mylist: followings.followings,
                        refresher: () {
                          setState(() {});
                        }),
                    settings: const RouteSettings(name: Following.routeName),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ProfileCount("Following",
                    followings != null ? followings.followings.length : 0)))
      ],
    );
  }

  Row profileMainButtonRowPrivate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ProfileCount("Moments", posts != null ? posts.length : 0)),
        Expanded(
            child: ProfileCount("Followers",
                followers != null ? followers.followers.length : 0)),
        Expanded(
            child: ProfileCount("Following",
                followings != null ? followings.followings.length : 0))
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
