// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'langpal_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LangpalUser _$LangpalUserFromJson(Map<String, dynamic> json) {
  return _LangpalUser.fromJson(json);
}

/// @nodoc
mixin _$LangpalUser {
  String get userID => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  LangpalUserInfo get info => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  int get point => throw _privateConstructorUsedError;

  /// Serializes this LangpalUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LangpalUserCopyWith<LangpalUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangpalUserCopyWith<$Res> {
  factory $LangpalUserCopyWith(
          LangpalUser value, $Res Function(LangpalUser) then) =
      _$LangpalUserCopyWithImpl<$Res, LangpalUser>;
  @useResult
  $Res call(
      {String userID,
      String displayName,
      String emailAddress,
      LangpalUserInfo info,
      bool isPremium,
      int point});

  $LangpalUserInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$LangpalUserCopyWithImpl<$Res, $Val extends LangpalUser>
    implements $LangpalUserCopyWith<$Res> {
  _$LangpalUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? displayName = null,
    Object? emailAddress = null,
    Object? info = null,
    Object? isPremium = null,
    Object? point = null,
  }) {
    return _then(_value.copyWith(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as LangpalUserInfo,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LangpalUserInfoCopyWith<$Res> get info {
    return $LangpalUserInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LangpalUserImplCopyWith<$Res>
    implements $LangpalUserCopyWith<$Res> {
  factory _$$LangpalUserImplCopyWith(
          _$LangpalUserImpl value, $Res Function(_$LangpalUserImpl) then) =
      __$$LangpalUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userID,
      String displayName,
      String emailAddress,
      LangpalUserInfo info,
      bool isPremium,
      int point});

  @override
  $LangpalUserInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$LangpalUserImplCopyWithImpl<$Res>
    extends _$LangpalUserCopyWithImpl<$Res, _$LangpalUserImpl>
    implements _$$LangpalUserImplCopyWith<$Res> {
  __$$LangpalUserImplCopyWithImpl(
      _$LangpalUserImpl _value, $Res Function(_$LangpalUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? displayName = null,
    Object? emailAddress = null,
    Object? info = null,
    Object? isPremium = null,
    Object? point = null,
  }) {
    return _then(_$LangpalUserImpl(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as LangpalUserInfo,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      point: null == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LangpalUserImpl implements _LangpalUser {
  _$LangpalUserImpl(
      {required this.userID,
      required this.displayName,
      required this.emailAddress,
      required this.info,
      required this.isPremium,
      required this.point});

  factory _$LangpalUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LangpalUserImplFromJson(json);

  @override
  final String userID;
  @override
  final String displayName;
  @override
  final String emailAddress;
  @override
  final LangpalUserInfo info;
  @override
  final bool isPremium;
  @override
  final int point;

  @override
  String toString() {
    return 'LangpalUser(userID: $userID, displayName: $displayName, emailAddress: $emailAddress, info: $info, isPremium: $isPremium, point: $point)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LangpalUserImpl &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.point, point) || other.point == point));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, userID, displayName, emailAddress, info, isPremium, point);

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LangpalUserImplCopyWith<_$LangpalUserImpl> get copyWith =>
      __$$LangpalUserImplCopyWithImpl<_$LangpalUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LangpalUserImplToJson(
      this,
    );
  }
}

abstract class _LangpalUser implements LangpalUser {
  factory _LangpalUser(
      {required final String userID,
      required final String displayName,
      required final String emailAddress,
      required final LangpalUserInfo info,
      required final bool isPremium,
      required final int point}) = _$LangpalUserImpl;

  factory _LangpalUser.fromJson(Map<String, dynamic> json) =
      _$LangpalUserImpl.fromJson;

  @override
  String get userID;
  @override
  String get displayName;
  @override
  String get emailAddress;
  @override
  LangpalUserInfo get info;
  @override
  bool get isPremium;
  @override
  int get point;

  /// Create a copy of LangpalUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LangpalUserImplCopyWith<_$LangpalUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
