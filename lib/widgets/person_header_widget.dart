import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';

class PersonHeaderWidget extends StatefulWidget {
  const PersonHeaderWidget({Key? key}) : super(key: key);

  @override
  State<PersonHeaderWidget> createState() => _PersonHeaderWidgetState();
}

class _PersonHeaderWidgetState extends State<PersonHeaderWidget> {
  bool isFollowing = false;

  changeFollowing() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.network(
            'https://pbs.twimg.com/profile_images/1498585975269830657/b3ac0hBJ_400x400.jpg',
          ),
        ),
        title: const Text('Carlos Sainz'),
        subtitle: const Text('@Carlossainz55'),
        trailing: InkWell(
          onTap: () => changeFollowing(),
          child: Container(
            width: 128,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isFollowing ? AppColors.textColor : Colors.transparent,
              border: Border.all(
                color: isFollowing ? Colors.transparent : AppColors.darkGrey,
                width: 1,
              ),
            ),
            child: Text(isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  color: isFollowing ? Colors.white : AppColors.textColor,
                  fontWeight: FontWeight.w500
                )),
          ),
        ));
  }
}
