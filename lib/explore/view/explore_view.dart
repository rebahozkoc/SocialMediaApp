import 'package:flutter/material.dart';
import 'package:sabanci_talks/post/view/single_post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/analytics.dart';

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}

// Search Page
class ExploreView extends StatefulWidget {
  ExploreView({Key? key}) : super(key: key);
  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final List<PhotoItem> _items = [
    PhotoItem(
        "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    PhotoItem(
        "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Liam Gant"),
    PhotoItem(
        "https://images.pexels.com/photos/1130847/pexels-photo-1130847.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    PhotoItem(
        "https://images.pexels.com/photos/45900/landscape-scotland-isle-of-skye-old-man-of-storr-45900.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/165779/pexels-photo-165779.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Scott Webb"),
    PhotoItem(
        "https://images.pexels.com/photos/548264/pexels-photo-548264.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Krivec Ales"),
    PhotoItem(
        "https://images.pexels.com/photos/188973/matterhorn-alpine-zermatt-mountains-188973.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/795188/pexels-photo-795188.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Melanie Wupper"),
    PhotoItem(
        "https://images.pexels.com/photos/5222/snow-mountains-forest-winter.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Jaymantri"),
    PhotoItem(
        "https://images.pexels.com/photos/789381/pexels-photo-789381.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Riciardus"),
    PhotoItem(
        "https://images.pexels.com/photos/326119/pexels-photo-326119.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/707344/pexels-photo-707344.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Eberhard"),
    PhotoItem(
        "https://images.pexels.com/photos/691034/pexels-photo-691034.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Mirsad Mujanovic"),
    PhotoItem(
        "https://images.pexels.com/photos/655676/pexels-photo-655676.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Vittorio Staffolani"),
    PhotoItem(
        "https://images.pexels.com/photos/592941/pexels-photo-592941.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Tobi"),
  ];

  @override
  Widget build(BuildContext context) {
    MyAnalytics.setCurrentScreen("Explore Page");
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 3,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_items[index].image),
                  ),
                ),
              ),
              onTap: () => NavigationService.instance
                  .navigateToPage(path: NavigationConstants.SINGLE_POST));
        },
      ),
    );
  }
}
