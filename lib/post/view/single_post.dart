import 'package:flutter/material.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/util/colors.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({Key? key}) : super(key: key);

  @override
  State<SinglePost> createState() => _SinglePostState();

  static const String routeName = '/singlePost';
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
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
            const SizedBox(
              height: 12,
            )
          ],
        ),
      );
}
