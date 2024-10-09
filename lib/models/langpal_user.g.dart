// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'langpal_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LangpalUserImpl _$$LangpalUserImplFromJson(Map<String, dynamic> json) =>
    _$LangpalUserImpl(
      userID: json['userID'] as String,
      displayName: json['displayName'] as String,
      emailAddress: json['emailAddress'] as String,
      info: LangpalUserInfo.fromJson(json['info'] as Map<String, dynamic>),
      isPremium: json['isPremium'] as bool,
      point: (json['point'] as num).toInt(),
    );

Map<String, dynamic> _$$LangpalUserImplToJson(_$LangpalUserImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'displayName': instance.displayName,
      'emailAddress': instance.emailAddress,
      'info': instance.info.toJson(),
      'isPremium': instance.isPremium,
      'point': instance.point,
    };
