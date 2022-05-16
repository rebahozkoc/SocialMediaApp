import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();

  static const String routeName = '/home';
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: _body(),
        ));
  }

  AppBar _appBar() => AppBar(
        title: const Text("Sabancı Talks"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {},
          ),
        ],
      );

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const Post(),
            separatorBuilder: (context, index) => const SizedBox(height: 12,),
            itemCount: 5),
      );
}

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> with TickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  bool isLiked = false;
  bool isSaved = false;

  changeLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  changeSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    controller.addListener(_setActiveTabIndex);
    super.initState();
  }

  void _setActiveTabIndex() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _header(),
        _images(),
        _actions(),
        likeCount(),
        _info(),
      ],
    );
  }

  ListTile _header() {
    return ListTile(
      leading: const CircleAvatar(
        foregroundImage: NetworkImage(
            'https://pbs.twimg.com/profile_images/1276567411240681472/8KdXHFdK_400x400.jpg'),
      ),
      title: const Text("Charles Leclers"),
      subtitle: const Text("@Charles_Leclerc"),
      trailing:
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
    );
  }

  SizedBox _images() => SizedBox(
        width: screenWidth(context),
        height: screenWidth(context),
        child: TabBarView(
          controller: controller,
          children: [
            _image(
                'https://pbs.twimg.com/media/FQ5Oa2cXEAA4Nxn?format=jpg&name=large'),
            _image(
                'https://pbs.twimg.com/media/FP5nGWzagAEheZA?format=jpg&name=large'),
            _image(
                'https://pbs.twimg.com/media/FOOx6piXoAUGYw7?format=jpg&name=large'),
          ],
        ),
      );

  AspectRatio _image(String url) => AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ));

  Padding _actions() => Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => changeLike(),
                    icon: Icon(
                      isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 30,
                    )),
                const SizedBox(width: 8),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 30,
                    )),
              ],
            ),
            IconButton(
                onPressed: () => changeSave(),
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  size: 30,
                )),
          ],
        ),
      );

  Padding likeCount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "123.456 Likes",
          style: kHeader4TextStyle,
          maxLines: 1,
        ),
      );

  Padding _info() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          text: TextSpan(
            text: "Charles_Leclers",
            style: kHeader4TextStyle,
            children: [
              TextSpan(
                text: " · ",
                style: kHeader4TextStyle!.copyWith(color: AppColors.darkGrey),
              ),
              TextSpan(
                text: "Pole Position babyyyyyyyy !"
                    "Happy with this, but it is only qualifying, let’s finish the job tomorrow 💪 "
                    "And so happy to see that after all the hard work of the last two years, we are back in the fight. ",
                style: kHeader4TextStyle!.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
        ),
      );
}
