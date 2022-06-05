import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_posts.g.dart';
part 'my_posts.freezed.dart';

@Freezed()
class MyPost with _$MyPost {
  const factory MyPost({
    required String uid,
    @Default("")
        date,
    @Default("empty")
        postText,
    @Default([
      "https://picsum.photos/600",
    ])
        pictureUrl,
  }) = _MyPost;

  factory MyPost.fromJson(Map<String, dynamic> json) => _$MyPostFromJson(json);
}
