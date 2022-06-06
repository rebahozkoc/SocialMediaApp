import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:sabanci_talks/util/colors.dart';

class PersonHeaderWidget extends StatefulWidget {
  PersonHeaderWidget({Key? key, required this.element}) : super(key: key);
  dynamic element;
  @override
  State<PersonHeaderWidget> createState() => _PersonHeaderWidgetState();
}

class _PersonHeaderWidgetState extends State<PersonHeaderWidget> {
  bool isFollowing = false;

  dynamic user;
  Firestore f = Firestore();
  Future<void> userList() async {
    user = await f.getUser(widget.element);
    debugPrint("userrrr ${user.toString()}");
  }

  changeFollowing() {
    setState(() {
      isFollowing = !isFollowing;
    });
    userList();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("helllooooo ${widget.element.toString()}");
    return FutureBuilder(
        future: userList(),
        builder: (context, snapshot) {
          return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  user != null
                      ? user[1].profilePicture
                      : "https://picsum.photos/600",
                ),
              ),
              title: Text(user != null ? user[1].fullName : ""),
              //subtitle: const Text('@Carlossainz55'),
              trailing: InkWell(
                onTap: () => changeFollowing(),
                child: Container(
                  width: 128,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        isFollowing ? AppColors.textColor : Colors.transparent,
                    border: Border.all(
                      color:
                          isFollowing ? Colors.transparent : AppColors.darkGrey,
                      width: 1,
                    ),
                  ),
                  child: Text(isFollowing ? 'Following' : 'Follow',
                      style: TextStyle(
                          color:
                              isFollowing ? Colors.white : AppColors.textColor,
                          fontWeight: FontWeight.w500)),
                ),
              ));
        });
  }
}
