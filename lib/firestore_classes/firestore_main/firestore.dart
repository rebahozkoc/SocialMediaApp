import 'dart:async';

import 'package:sabanci_talks/firestore_classes/comment/my_comment.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/firestore_classes/following/following.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Firestore {
  dynamic myData;

  late SharedPreferences prefs;
  String? uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comment');

  CollectionReference followerss =
      FirebaseFirestore.instance.collection('follower');
  CollectionReference followingss =
      FirebaseFirestore.instance.collection('following');
  Future<String?> decideUser() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  Future<void> addUser(uid, fullName) async {
    myUser = await users.add({
      "uid": uid,
      "fullName": fullName,
      "gender": "not selected",
      "private": false,
      "biography": "",
      "profilePicture":
          "https://www.innovaxn.eu/wp-content/uploads/blank-profile-picture-973460_1280.png",
      "postCount": 0,
      "following": 0,
      "follower": 0
    });
  }

  Future<void> UpdateUser(
      docId, fullName, gender, biography, profilePicture) async {
    await users
        .doc(docId)
        .update({
          "fullName": fullName,
          "gender": gender,
          "biography": biography,
          "profilePicture": profilePicture,
        })
        .then((_) => print("success"))
        .catchError((error) => print('Failed: $error'));
  }

  Future<List<dynamic>?> getUser(uid) async {
    dynamic show;
    dynamic docId;
    myData = await users
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((doc) {
              show = [
                doc.id,
                MyUser.fromJson(doc.data() as Map<String, dynamic>)
              ];
            }).toList());
    //debugPrint("show is now ${show.toString()}");
    return show;
  }

  Future addUser(
    String uid,
    String fullName,
    String mail,
  ) async {}

  // Future<List<dynamic>> getUserByReference(mylist) {
  //   return mylist.map((item) async {
  //     return await item.get().then((value) {
  //       return MyUser.fromJson(value.data() as Map<String, dynamic>);
  //     });
  //   }).toList();
  // }

  Future<dynamic> getFollowers(uid) async {
    dynamic follower;
    myData = await followerss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        follower = Follower.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });

    return follower;
  }

  Future<dynamic> getFollowings(uid) async {
    dynamic following;
    myUser = await followingss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        following = Following.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });

    return following;
  }

  Future<List<dynamic>?> getPost(uid) async {
    debugPrint("uid: ${uid}");
    dynamic posts2;
    myData = await posts.where("uid", isEqualTo: uid).get().then((value) {
      posts2 = value.docs.map((doc) {
        return [doc.id, MyPost.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }

  Future<MyPost?> getSpecificPost(documentId) async {
    dynamic posts2;
    myData = await posts.doc(documentId).get().then((value) =>
        {posts2 = MyPost.fromJson(value.data() as Map<String, dynamic>)});
    debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }


  Future<List<dynamic>?> getFeedPostsByLimit(int limit) async {
    dynamic posts2;
    myData = await posts.orderBy("createdAt", descending: true).limit(limit).get().then((value) {
      posts2 = value.docs.map((doc) {
        return [doc.id, MyPost.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }


  Future<void> addPost(
      {required uid,
      required createdAt,
      required urlArr,
      required postText}) async {
    myData = await posts.add({
      "uid": uid,
      "createdAt": createdAt,
      "postText": postText,
      "pictureUrlArr": urlArr,
      "likeArr": []
    });
    return;
  }

  Future<void> addComment(
      {required postid, required uid, required comment}) async {
    myData =
        await comment.add({"postid": postid, "uid": uid, "comment": comment});
    return;
  }

    Future<List<dynamic>?> getAllComments(postid) async {
    debugPrint("postid: ${postid}");
    dynamic result;
    myData = await comment.where("postid", isEqualTo: postid).get().then((value) {
          result = value.docs.map((doc) {
            return [
              doc.id,
              MyComment.fromJson(doc.data() as Map<String, dynamic>)
            ];
          }).toList();
        });
    //debugPrint("Post is ${posts2.toString()}");
    return result;
  }
}
