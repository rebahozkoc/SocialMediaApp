import 'package:flutter/material.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({ Key? key }) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: Text("Explore")),
    );
  }
}