import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/widgets/comment_widget.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  static const String routeName = '/comments';

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: _body());
  }

  SafeArea _body() => SafeArea(
          child: Column(
        children: [
          _comments(),
          _footer(),
        ],
      ));

  Expanded _comments() {
    return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            shrinkWrap: false,
            itemBuilder: (context, index) => const CommentWidget(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: 12,
          ),
        );
  }

  Container _footer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [_image(), const SizedBox(width: 16), sendComment()],
      ),
    );
  }

  ClipRRect _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.network(
        'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg',
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded sendComment() => Expanded(
        child: Container(
          height: 48,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.darkGrey, width: 1)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: controller,
            autocorrect: false,
            enableSuggestions: false,
            autofocus: false,
            decoration: const InputDecoration(
                hintText: "Add a comment",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.all(0)),
          ),
        ),
      );
}
