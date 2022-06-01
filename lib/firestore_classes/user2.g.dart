// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      json['full_name'] as String?,
      json['age'] as int?,
      json['gender'] as String?,
      json['biography'] as String?,
      json['uid'] as String?,
      json['follower'] as int,
      json['following'] as int,
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'full_name': instance.full_name,
      'age': instance.age,
      'gender': instance.gender,
      'biography': instance.biography,
      'uid': instance.uid,
      'follower': instance.follower,
      'following': instance.following,
    };
