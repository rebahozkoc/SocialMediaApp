import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_posts.g.dart';
part 'my_posts.freezed.dart';

DateTime _createdAtFromJson(Timestamp timestamp) => timestamp.toDate();
Timestamp _createdAtToJson(DateTime date) => Timestamp.fromDate(date);

@Freezed()
class MyPost with _$MyPost {
  const factory MyPost({
    required String uid,
    @JsonKey(name: 'created_at', fromJson: _createdAtFromJson, toJson: _createdAtToJson)
        required DateTime createdAt,
    @Default("empty")
        String postText,
    @Default([
      "https://picsum.photos/600",
    ])
        List<String> pictureUrlArr,
    @Default([
      ""
    ]) 
        List<String> likeArr,
       
  }) = _MyPost;

  factory MyPost.fromJson(Map<String, dynamic> json) => _$MyPostFromJson(json);
}
