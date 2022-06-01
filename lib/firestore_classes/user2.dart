import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user2.g.dart';

@JsonSerializable()
class MyUser {
  String? full_name;
  int? age;
  String? gender;
  String? biography;
  String? uid;
  int follower = 0;
  int following = 0;

  MyUser(this.full_name, this.age, this.gender, this.biography, this.uid,
      this.follower, this.following);
  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
