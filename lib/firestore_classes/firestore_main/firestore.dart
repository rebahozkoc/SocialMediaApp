import 'dart:async';
import 'package:sabanci_talks/firestore_classes/comment/my_comment.dart';
import 'package:sabanci_talks/firestore_classes/follower/follower.dart';
import 'package:sabanci_talks/firestore_classes/following/following.dart';
import 'package:sabanci_talks/firestore_classes/notifications/notification.dart';

import 'package:sabanci_talks/firestore_classes/requests/request.dart';
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
  CollectionReference requestss =
      FirebaseFirestore.instance.collection('request');

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        USER
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<String?> decideUser() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  Future<void> addUser(uid, fullName) async {
    myData = await users.add({
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
    createFollowers(uid);
    createFollowing(uid);
    createRequests(uid);
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
    return show;
  }
  //needs to be implemented
  //change profile picture
  //update privacy
  //delete user

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        follower-following-request
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Getter functions for follower-following-request
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
    myData = await followingss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        following = Following.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    return following;
  }

  Future<dynamic> getRequestss(uid) async {
    dynamic request;
    myData = await requestss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        request = Request.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    return request;
  }

  // checker functions for follower-following-request
  Future<bool> isPrivate(uid) async {
    dynamic isPrivate;
    await getUser(uid)
        .then((value) => isPrivate = value != null ? value[1].private : true);
    return isPrivate;
  }

  //Is uid followed by followuid?
  Future<bool> isFollowed(uid, followUid) async {
    dynamic followingList = await getFollowings(uid);
    for (int i = 0; i < followingList.followings.length; i++) {
      if (await followingList.followings[i] == followUid) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isRequested(uid, followUid) async {
    dynamic requestList = await getRequestss(uid);
    for (int i = 0; i < requestList.requests.length; i++) {
      if (await requestList.followings[i] == followUid) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isReqandFollow(uid, followUid) async {
    dynamic isreq = await isRequested(uid, followUid);
    dynamic isfol = await isFollowed(uid, followUid);
    return !(await isreq && await isfol);
  }

  //Find docId functions for follower-following-request
  Future<dynamic> findFollowerDocId(uid) async {
    dynamic docId;
    myData = await followerss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  Future<dynamic> findFollowingDocId(uid) async {
    dynamic docId;
    myData = await followingss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  Future<dynamic> findRequestsDocId(uid) async {
    dynamic docId;
    myData = await requestss.where("uid", isEqualTo: uid).get().then((value) {
      value.docs.map((doc) {
        docId = doc.id;
      }).toList();
    });
    return docId;
  }

  //Adder functions for follower-following-request

  // add followUid to follower list of uid
  Future<void> addFollow(uid, followUid) async {
    dynamic docId = await findFollowerDocId(uid);
    followerss.doc(docId).update({
      "followers": FieldValue.arrayUnion([followUid])
    });
    return;
  }

  // add followingUid to following list of uid
  Future<void> addFollowing(uid, followingUid) async {
    dynamic docId = await findFollowingDocId(uid);
    followingss.doc(docId).update({
      "followers": FieldValue.arrayUnion([followingUid])
    });
    return;
  }

  // add requesUid to request list of uid
  Future<void> addRequest(uid, requestId) async {
    dynamic docId = await findRequestsDocId(uid);
    requestss.doc(docId).update({
      "followers": FieldValue.arrayUnion([requestId])
    });
    return;
  }

  //Delete functions for follower-following-request

  //uid unfollowed by followuid
  Future<void> unFollow(uid, followUid) async {
    dynamic docId = await findFollowerDocId(uid);
    followerss.doc(docId).update({
      "followers": FieldValue.arrayRemove([followUid])
    });
    return;
  }

  // uid unfollowed followinguid
  Future<void> deleteFollowing(uid, followingUid) async {
    dynamic docId = await findFollowingDocId(uid);
    followingss.doc(docId).update({
      "followers": FieldValue.arrayRemove([followingUid])
    });
    return;
  }

  // uid delete requestId
  Future<void> deleteRequest(uid, requestId) async {
    dynamic docId = await findRequestsDocId(uid);
    requestss.doc(docId).update({
      "followers": FieldValue.arrayRemove([requestId])
    });
    return;
  }

  // Create functions for follower-following-request

  Future<void> createFollowers(uid) async {
    myData = await followerss.add({"uid": uid, "followers": []});
  }

  Future<void> createFollowing(uid) async {
    myData = await followingss.add({"uid": uid, "followings": []});
  }

  Future<void> createRequests(uid) async {
    myData = await requestss.add({"uid": uid, "requests": []});
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        Notifications
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<dynamic>?> getNotification(uid) async {
    dynamic myNotifications;
    myData = await posts.where("uid", isEqualTo: uid).get().then((value) {
      myNotifications = value.docs.map((doc) {
        return Notifications.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return myNotifications;
  }

  Future<void> addNotification(
      {required uid,
      required notification_type,
      required uid_sub,
      required isPost}) async {
    myData = await posts.add({
      "uid": uid,
      "notification_type": notification_type,
      "uid_sub": uid_sub,
      "isPost": isPost,
    });
    return;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //        POSTS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<MyPost?> getSpecificPost(documentId) async {
    dynamic posts2;
    myData = await posts.doc(documentId).get().then((value) =>
        {posts2 = MyPost.fromJson(value.data() as Map<String, dynamic>)});
    debugPrint("Post is ${posts2.toString()}");
    return posts2;
  }

  Future<List<dynamic>?> getFeedPostsByLimit(int limit) async {
    dynamic posts2;
    myData = await posts
        .orderBy("createdAt", descending: true)
        .limit(limit)
        .get()
        .then((value) {
      posts2 = value.docs.map((doc) {
        return [doc.id, MyPost.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return posts2;
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
    myData =
        await comment.where("postid", isEqualTo: postid).get().then((value) {
      result = value.docs.map((doc) {
        return [doc.id, MyComment.fromJson(doc.data() as Map<String, dynamic>)];
      }).toList();
    });
    //debugPrint("Post is ${posts2.toString()}");
    return result;
  }
}
