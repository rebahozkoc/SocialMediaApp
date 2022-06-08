import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';

class NotificationWidget extends StatefulWidget {
  NotificationWidget({Key? key, required this.notification}) : super(key: key);
  dynamic notification;
  @override
  State<NotificationWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  int index = 0;

  bool isFollowed = false;
  String type = "like";
  bool isFollow = true;

  @override
  void initState() {
    super.initState();
    //debugPrint("notification widget ${widget.notification.toString()}");
  }

  dynamic comingUser;
  dynamic meUser;
  Future<void> findNotification() async {
    Firestore f = Firestore();
    comingUser = await f.getUser(widget.notification.uid_sub);
    meUser = await f.getUser(widget.notification.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _like("@Charles_Leclers", "comment"),
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

  Padding _like(person, type) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(
              radius: 24,
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
                      text: type == "like"
                          ? " is liked your photo."
                          : type == "comment"
                              ? " commented on your photo."
                              : " tagged you.",
                      style:
                          notificationEnd!.copyWith(color: AppColors.darkGrey),
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
