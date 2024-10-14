// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: json['id'] as String,
      ownerID: json['ownerID'] as String,
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerID': instance.ownerID,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
    };
