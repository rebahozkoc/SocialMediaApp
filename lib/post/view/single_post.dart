import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';

class SinglePost extends StatefulWidget {

  const SinglePost(
      {Key? key,
      required this.docId,
      required this.proUrl,
      required this.name,
      required this.date
      })
      : super(key: key);
  final String docId;
  final String proUrl;
  final String name;
  final String date;
  
  @override
  State<SinglePost> createState() => _SinglePostState();

  static const String routeName = '/singlePost';
}

class _SinglePostState extends State<SinglePost> {
  MyPost? post;
  List<Content> contents = [];

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    post = await f.getSpecificPost(widget.docId);
      for (String url in post!.pictureUrlArr) {
      contents.add(Content(
        type: "image",
        contentId: url,
        source: url,
      ));
    }
    
    debugPrint("contents: ${contents.length}");
    for (int i = 0; i < contents.length; i++) {
      debugPrint("contents[$i]: ${contents[i].source}");
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return FutureBuilder(
        future: getMyPost(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        });
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
                name: widget.name,
                date: widget.date,
                profileImg: widget.proUrl,
                likeCount: 58100000,
                commentCount: 58,
                contentCount: contents.length,
                postText: post != null ? post!.postText : "",
                contents: contents.isNotEmpty ? contents : [
                  Content(
                    type: "image",
                    contentId: "text",
                    source: post != null && post!.pictureUrlArr.isNotEmpty
                        ? post!.pictureUrlArr[0]
                        : "https://picsum.photos/400",
                  )
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
