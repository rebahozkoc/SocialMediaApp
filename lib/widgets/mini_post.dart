import 'package:flutter/material.dart';


class MiniPost extends StatelessWidget {
  final String url;
  const MiniPost(this.url, { Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Image.network(url);

    
  }
}


