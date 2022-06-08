import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sabanci_talks/post/functions/post_functions.dart';
import 'package:sabanci_talks/post/view/post_view.dart';

class SinglePostView extends StatefulWidget {
  final PostHeroModel post;
  final PageController pageController;

  SinglePostView({Key? key, required this.post})
      : pageController = PageController(initialPage: post.index!),
        super(key: key);

  @override
  State<SinglePostView> createState() => _SinglePostViewState();
}

class _SinglePostViewState extends State<SinglePostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _leading(context),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: _gallery()),
              SizedBox(height: 56, width: double.infinity, child: _buttons())
            ],
          ),
        ),
      ),
    );
  }

  IconButton _leading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Padding _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                constraints: const BoxConstraints(),
                icon: const Icon(CupertinoIcons.heart),
                color: Colors.white,
                iconSize: 24,
                onPressed: () {},
              ),
              _integrationCount(convertCount(widget.post.likeCount!))
            ],
          ),
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                constraints: const BoxConstraints(),
                icon: const Icon(CupertinoIcons.bubble_left),
                color: Colors.white,
                iconSize: 24,
                onPressed: () {},
              ),
              _integrationCount(convertCount(widget.post.commentCount!))
            ],
          ),
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                constraints: const BoxConstraints(),
                icon: const Icon(CupertinoIcons.arrowshape_turn_up_right),
                color: Colors.white,
                iconSize: 24,
                onPressed: () {},
              ),
              _integrationCount("")
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _integrationCount(String count) => SizedBox(
        width: 36.5,
        child: Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      );

  PhotoViewGallery _gallery() {
    return PhotoViewGallery.builder(
      pageController: widget.pageController,
      itemCount: widget.post.contentCount,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            widget.post.imgUrls![index],
          ),
          onScaleEnd: (context, tapUpDetails, value) {
            Navigator.pop(context);
          },
        );
      },
      onPageChanged: (index) {
        setState(() {
          widget.post.index = index;
        });
      },
    );
  }
}
