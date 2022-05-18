import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/styles.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://pbs.twimg.com/profile_images/1498585975269830657/b3ac0hBJ_400x400.jpg',
        ),
      ),
      title: RichText(
        text: TextSpan(
          text: '@Carlossainz55 ',
          style: kHeader4TextStyle,
          children: const [
            TextSpan(
              text:
                  'Antes de empezar la temporada hice un viaje relámpago de Italia a Valencia para disfrutar de unas sesiones de karting duras pero muy divertidas con amigos. El entreno de pretemporada perfecto!! 🔝💪🏼',
              style: TextStyle(
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
