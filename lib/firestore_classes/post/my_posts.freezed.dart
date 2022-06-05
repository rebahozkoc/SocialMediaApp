// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_posts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyPost _$MyPostFromJson(Map<String, dynamic> json) {
  return _MyPost.fromJson(json);
}

/// @nodoc
mixin _$MyPost {
  String get uid => throw _privateConstructorUsedError;
  dynamic get date => throw _privateConstructorUsedError;
  dynamic get postText => throw _privateConstructorUsedError;
  dynamic get pictureUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyPostCopyWith<MyPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPostCopyWith<$Res> {
  factory $MyPostCopyWith(MyPost value, $Res Function(MyPost) then) =
      _$MyPostCopyWithImpl<$Res>;
  $Res call({String uid, dynamic date, dynamic postText, dynamic pictureUrl});
}

/// @nodoc
class _$MyPostCopyWithImpl<$Res> implements $MyPostCopyWith<$Res> {
  _$MyPostCopyWithImpl(this._value, this._then);

  final MyPost _value;
  // ignore: unused_field
  final $Res Function(MyPost) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? date = freezed,
    Object? postText = freezed,
    Object? pictureUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postText: postText == freezed
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as dynamic,
      pictureUrl: pictureUrl == freezed
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_MyPostCopyWith<$Res> implements $MyPostCopyWith<$Res> {
  factory _$$_MyPostCopyWith(_$_MyPost value, $Res Function(_$_MyPost) then) =
      __$$_MyPostCopyWithImpl<$Res>;
  @override
  $Res call({String uid, dynamic date, dynamic postText, dynamic pictureUrl});
}

/// @nodoc
class __$$_MyPostCopyWithImpl<$Res> extends _$MyPostCopyWithImpl<$Res>
    implements _$$_MyPostCopyWith<$Res> {
  __$$_MyPostCopyWithImpl(_$_MyPost _value, $Res Function(_$_MyPost) _then)
      : super(_value, (v) => _then(v as _$_MyPost));

  @override
  _$_MyPost get _value => super._value as _$_MyPost;

  @override
  $Res call({
    Object? uid = freezed,
    Object? date = freezed,
    Object? postText = freezed,
    Object? pictureUrl = freezed,
  }) {
    return _then(_$_MyPost(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed ? _value.date : date,
      postText: postText == freezed ? _value.postText : postText,
      pictureUrl: pictureUrl == freezed ? _value.pictureUrl : pictureUrl,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyPost implements _MyPost {
  const _$_MyPost(
      {required this.uid,
      this.date = "",
      this.postText = "empty",
      this.pictureUrl = const ["https://picsum.photos/600"]});

  factory _$_MyPost.fromJson(Map<String, dynamic> json) =>
      _$$_MyPostFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final dynamic date;
  @override
  @JsonKey()
  final dynamic postText;
  @override
  @JsonKey()
  final dynamic pictureUrl;

  @override
  String toString() {
    return 'MyPost(uid: $uid, date: $date, postText: $postText, pictureUrl: $pictureUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyPost &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.postText, postText) &&
            const DeepCollectionEquality()
                .equals(other.pictureUrl, pictureUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(postText),
      const DeepCollectionEquality().hash(pictureUrl));

  @JsonKey(ignore: true)
  @override
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      __$$_MyPostCopyWithImpl<_$_MyPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyPostToJson(this);
  }
}

abstract class _MyPost implements MyPost {
  const factory _MyPost(
      {required final String uid,
      final dynamic date,
      final dynamic postText,
      final dynamic pictureUrl}) = _$_MyPost;

  factory _MyPost.fromJson(Map<String, dynamic> json) = _$_MyPost.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  dynamic get date => throw _privateConstructorUsedError;
  @override
  dynamic get postText => throw _privateConstructorUsedError;
  @override
  dynamic get pictureUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      throw _privateConstructorUsedError;
}
