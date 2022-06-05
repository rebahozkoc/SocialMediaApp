import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Firestore {
  dynamic myUser;
  late SharedPreferences prefs;
  String? uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Future<String?> decideUser() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  Future<MyUser?> getUser(uid) async {
    dynamic show;
    myUser = await users
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((doc) {
              show = MyUser.fromJson(doc.data() as Map<String, dynamic>);
            }).toList());
    //debugPrint("show is now ${show.toString()}");
    return show;
  }

  Future<List<MyPost?>?> getPost(uid) async {
    dynamic posts2;
    myUser = await posts.where("uid", isEqualTo: uid).get().then((value) => {
          posts2 = value.docs.map((doc) {
            return MyPost.fromJson(doc.data() as Map<String, dynamic>);
          }).toList()
        });
    debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }

  Future<void> addPost(uid, url, posttext) async {
    myUser =
        await posts.add({"pictureUrl": url, "postText": posttext, "uid": uid});
    return;
  }
}
