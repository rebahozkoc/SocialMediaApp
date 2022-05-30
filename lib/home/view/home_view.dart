import 'package:flutter/material.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<HomeView> createState() => _HomeViewState();

  static const String routeName = '/home';
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    _setCurrentScreen();
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'Home Page',
      screenClassOverride: 'homePage',
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text("Sabanci Talks"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () {},
          ),
        ],
      );

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: ListView(
          primary: true,
          shrinkWrap: true,
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
            PostView(
              postModel: PostModel(
                name: "Charles Leclerc",
                date: "2021-03-20T20:18:04.000Z",
                profileImg:
                    "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
                likeCount: 111111111,
                commentCount: 583453,
                contentCount: 3,
                postText: "This means so much...",
                contents: [
                  Content(
                      type: "image",
                      contentId: "text",
                      source:
                          "https://pbs.twimg.com/media/FOYNTX9XwAMy_Wu?format=jpg&name=large"),
                  Content(
                      type: "image",
                      contentId: "text",
                      source:
                          "https://pbs.twimg.com/media/FOYNTX9XwAMy_Wu?format=jpg&name=large"),
                  Content(
                      type: "image",
                      contentId: "text",
                      source:
                          "https://pbs.twimg.com/media/FOYNTX9XwAMy_Wu?format=jpg&name=large"),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      );
}
