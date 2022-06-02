// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyPost _$$_MyPostFromJson(Map<String, dynamic> json) => _$_MyPost(
      uid: json['uid'] as String,
      commentCount: json['commentCount'] ?? 0,
      likeCount: json['likeCount'] ?? 0,
      postText: json['postText'] ?? "empty",
      pictureUrl: json['pictureUrl'] ?? const ["https://picsum.photos/600"],
    );

Map<String, dynamic> _$$_MyPostToJson(_$_MyPost instance) => <String, dynamic>{
      'uid': instance.uid,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'postText': instance.postText,
      'pictureUrl': instance.pictureUrl,
    };
