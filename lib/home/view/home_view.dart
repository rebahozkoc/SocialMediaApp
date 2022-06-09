import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/util/analytics.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();

  static const String routeName = '/home';
}

class _HomeViewState extends State<HomeView> {
  List<PostView> posts = [];
  List<dynamic> postsJSONs = [];
  Future<void> getMyPost() async {
    Firestore f = Firestore();
    postsJSONs = await f.getFeedPostsByLimit(5);
    debugPrint("postsJSONs: ${postsJSONs}");
    for (dynamic post in postsJSONs) {
      posts.add(PostView(
        postModel: PostModel(
          name: "Post testi",
          date: post[1].createdAt,
          profileImg:
              "https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg",
          likeCount: post[1].likeArr.length,
          commentCount: 58,
          contentCount: post[1].pictureUrlArr.length,
          postText: post[1].postText,
           contents: post[1].pictureUrlArr.map<Content>((url) {
            return Content(
              type: "image",
              contentId: url,
              source: url,
            );
          }).toList()    
         
          
          
          
        ),
      ));
    }

    debugPrint("posts: ${posts.length}");
    for (int i = 0; i < posts.length; i++) {
      debugPrint("posts[$i]: ${posts[i].postModel.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Home Page");
    return FutureBuilder(
        future: getMyPost(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: const Text("Home page is loading")));
            default:
              return Scaffold(
                appBar: _appBar(),
                body: SizedBox(
                  width: double.infinity,
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: posts,
                  ),
                ),
              );
          }
        });
  }

  AppBar _appBar() => AppBar(
        title: const Text("Sabanci Talks"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () => NavigationService.instance
                .navigateToPage(path: NavigationConstants.CHAT_LIST),
          ),
        ],
      );
}
