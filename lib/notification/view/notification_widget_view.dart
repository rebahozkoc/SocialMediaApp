import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/home/view/comment_view.dart';
import 'package:sabanci_talks/home/view/likes_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  
  bool isFollowed = false;
  String type = "like";
  bool isFollow = true;
  
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(_setActiveTabIndex);
    super.initState();
  }


  void _changeFollowed() {
    setState(() {
      isFollowed = !isFollowed;
    });
  }

  void _setActiveTabIndex() {
    setState(() {
      index = controller.index;
    });
  }

  void _tofollow() {
    setState(() {
      isFollow = !isFollow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _like("Charles_Leclers", "comment"),
        //_comment("Charles_Leclers"),
        //_wannafollow("Gorkem Yar")
      ],
    );
  }

  ListTile _header() {
    return const ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(
            'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
      ),
      title: Text("Charles Leclers"),
      subtitle: Text("@Charles_Leclerc"),
    );
  }

  Padding _like(person,type) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: RichText(
                text: TextSpan(
                  text: person,
                  style: notificationBegin,
                  children: [
                    TextSpan(
                      text: type=="like" ? " is liked your photo.": type=="comment" ?" commented on your photo.":" tagged you.",
                      style: notificationEnd!.copyWith(color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
            Image.network(
              "https://media-exp1.licdn.com/dms/image/C4E03AQGJosc9amqoKg/profile-displayphoto-shrink_400_400/0/1634824779204?e=1658361600&v=beta&t=5rsoZYQaQ0s-P9SUmuOULqyWKXyiWnLLZyD2EgcKBS0",
              width: 50,
              height: 50,
            ),
          ]),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
            color: AppColors.primary,
          ),
        ],
      ));

 
  Padding _follow(person) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: RichText(
                text: TextSpan(
                  text: person,
                  style: commentBegin,
                  children: [
                    TextSpan(
                      text: " followed you.",
                      style: commentEnd!.copyWith(color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),

            TextButton(
              onPressed: _tofollow,
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory
              ),
              child: Container(
                child:Text(isFollow ? "Following" : "Follow", style:followbutton),
                width: screenWidth(context, dividedBy: 3),
                height: screenHeight(context, dividedBy: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isFollow ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isFollow ? Colors.transparent : AppColors.darkGrey,
                    width: 1,
                    ),
                  )
                ),  
              )
          ]),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
            color: AppColors.primary,
          ),
        ],
      ));
      Padding _wannafollow(person) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: RichText(
                text: TextSpan(
                  text: person,
                  style: commentBegin,
                  children: [
                    TextSpan(
                      text: " followed you.",
                      style: commentEnd!.copyWith(color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),

            TextButton(
              onPressed: _tofollow,
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory
              ),
              child: Container(
                child:Text("Accept", style:followbutton),
                width: screenWidth(context, dividedBy: 6),
                height: screenHeight(context, dividedBy: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue,
                  border: Border.all(
                    color: isFollow ? Colors.transparent : AppColors.darkGrey,
                    width: 1,
                    ),
                  )
                ),  
              ),
               TextButton(
              onPressed: _tofollow,
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory
              ),
              child: Container(
                child:Text("Decline", style:followbutton),
                width: screenWidth(context, dividedBy: 6),
                height: screenHeight(context, dividedBy: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primary,
                  border: Border.all(
                    color: isFollow ? Colors.transparent : AppColors.darkGrey,
                    width: 1,
                    ),
                  )
                ),  
              )
          ]),

          
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.1,
            color: AppColors.primary,
          ),
        ],
      ),
      );

    }
    