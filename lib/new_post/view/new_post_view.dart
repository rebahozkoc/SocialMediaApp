
import 'package:flutter/material.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({ Key? key }) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("New Post")),
    );
  }
}
