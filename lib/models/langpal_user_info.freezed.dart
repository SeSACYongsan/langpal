// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'langpal_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LangpalUserInfo _$LangpalUserInfoFromJson(Map<String, dynamic> json) {
  return _LangpalUserInfo.fromJson(json);
}

/// @nodoc
mixin _$LangpalUserInfo {
  Language get firstLanguage => throw _privateConstructorUsedError;
  Language get targetLanguage => throw _privateConstructorUsedError;
  Level get level => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LangpalUserInfoCopyWith<LangpalUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangpalUserInfoCopyWith<$Res> {
  factory $LangpalUserInfoCopyWith(
          LangpalUserInfo value, $Res Function(LangpalUserInfo) then) =
      _$LangpalUserInfoCopyWithImpl<$Res, LangpalUserInfo>;
  @useResult
  $Res call(
      {Language firstLanguage,
      Language targetLanguage,
      Level level,
      String username});
}

/// @nodoc
class _$LangpalUserInfoCopyWithImpl<$Res, $Val extends LangpalUserInfo>
    implements $LangpalUserInfoCopyWith<$Res> {
  _$LangpalUserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstLanguage = null,
    Object? targetLanguage = null,
    Object? level = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      firstLanguage: null == firstLanguage
          ? _value.firstLanguage
          : firstLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      targetLanguage: null == targetLanguage
          ? _value.targetLanguage
          : targetLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LangpalUserInfoImplCopyWith<$Res>
    implements $LangpalUserInfoCopyWith<$Res> {
  factory _$$LangpalUserInfoImplCopyWith(_$LangpalUserInfoImpl value,
          $Res Function(_$LangpalUserInfoImpl) then) =
      __$$LangpalUserInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Language firstLanguage,
      Language targetLanguage,
      Level level,
      String username});
}

/// @nodoc
class __$$LangpalUserInfoImplCopyWithImpl<$Res>
    extends _$LangpalUserInfoCopyWithImpl<$Res, _$LangpalUserInfoImpl>
    implements _$$LangpalUserInfoImplCopyWith<$Res> {
  __$$LangpalUserInfoImplCopyWithImpl(
      _$LangpalUserInfoImpl _value, $Res Function(_$LangpalUserInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstLanguage = null,
    Object? targetLanguage = null,
    Object? level = null,
    Object? username = null,
  }) {
    return _then(_$LangpalUserInfoImpl(
      firstLanguage: null == firstLanguage
          ? _value.firstLanguage
          : firstLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      targetLanguage: null == targetLanguage
          ? _value.targetLanguage
          : targetLanguage // ignore: cast_nullable_to_non_nullable
              as Language,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LangpalUserInfoImpl implements _LangpalUserInfo {
  _$LangpalUserInfoImpl(
      {required this.firstLanguage,
      required this.targetLanguage,
      required this.level,
      required this.username});

  factory _$LangpalUserInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LangpalUserInfoImplFromJson(json);

  @override
  final Language firstLanguage;
  @override
  final Language targetLanguage;
  @override
  final Level level;
  @override
  final String username;

  @override
  String toString() {
    return 'LangpalUserInfo(firstLanguage: $firstLanguage, targetLanguage: $targetLanguage, level: $level, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LangpalUserInfoImpl &&
            (identical(other.firstLanguage, firstLanguage) ||
                other.firstLanguage == firstLanguage) &&
            (identical(other.targetLanguage, targetLanguage) ||
                other.targetLanguage == targetLanguage) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, firstLanguage, targetLanguage, level, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LangpalUserInfoImplCopyWith<_$LangpalUserInfoImpl> get copyWith =>
      __$$LangpalUserInfoImplCopyWithImpl<_$LangpalUserInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LangpalUserInfoImplToJson(
      this,
    );
  }
}

abstract class _LangpalUserInfo implements LangpalUserInfo {
  factory _LangpalUserInfo(
      {required final Language firstLanguage,
      required final Language targetLanguage,
      required final Level level,
      required final String username}) = _$LangpalUserInfoImpl;

  factory _LangpalUserInfo.fromJson(Map<String, dynamic> json) =
      _$LangpalUserInfoImpl.fromJson;

  @override
  Language get firstLanguage;
  @override
  Language get targetLanguage;
  @override
  Level get level;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$LangpalUserInfoImplCopyWith<_$LangpalUserInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
