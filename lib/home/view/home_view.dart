import 'package:flutter/material.dart';
import 'package:sabanci_talks/widgets/post_widget.dart';
import 'package:sabanci_talks/util/colors.dart';

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
            icon: const Icon(Icons.chat, color: AppColors.secondary),
            onPressed: () {},
          ),
        ],
      );

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const PostWidget(),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
            itemCount: 5),
      );
}
