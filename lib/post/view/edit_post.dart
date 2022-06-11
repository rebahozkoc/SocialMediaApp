import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';

class EditPost extends StatefulWidget {
  const EditPost(
      {Key? key,
      required this.docId,
      required this.proUrl,
      required this.name,
      required this.date})
      : super(key: key);
  final String docId;
  final String proUrl;
  final String name;
  final String date;

  @override
  State<EditPost> createState() => _EditPostState();

  static const String routeName = '/singlePost';
}

class _EditPostState extends State<EditPost> {
  MyPost? post;
  List<Content> contents = [];

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    post = await f.getSpecificPost(widget.docId);
    contents = [];
    for (String url in post!.pictureUrlArr) {
      contents.add(Content(
        type: "image",
        contentId: url,
        source: url,
      ));
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
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {},
          ),
        ],
      );

  SizedBox _body() {
    debugPrint("contents $contents");
    return SizedBox(
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
              likeCount: post != null ? post!.likeArr.length : 0,
              commentCount: 58,
              contentCount: contents.length,
              postText: post != null ? post!.postText : "",
              contents: contents,
              postId: widget.docId,
            ),
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
