import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:sabanci_talks/firestore_classes/user/my_user.dart';

class AddUser {
  String? fullName;
  int? age;
  String? gender;
  String? biography;
  String? uid;
  int follower = 0;
  int following = 0;

  AddUser(this.fullName, this.age, this.gender, this.biography, this.uid,
      this.follower, this.following);
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName, // John Doe
          'biography': biography, // .....
          'age': age, // 42
          'gender': gender, //Male
          "uid": uid,
          "follower": follower,
          "following": following,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<dynamic> getUser(uid) async {
    dynamic temp;
    dynamic myUser = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((event) {
      temp = event;
    });
    return temp;
  }
}
