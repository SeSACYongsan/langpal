// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerImpl _$$AnswerImplFromJson(Map<String, dynamic> json) => _$AnswerImpl(
      id: json['id'] as String,
      ownerID: json['ownerID'] as String,
      ownerUsername: json['ownerUsername'] as String,
      questionID: json['questionID'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$AnswerImplToJson(_$AnswerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerID': instance.ownerID,
      'ownerUsername': instance.ownerUsername,
      'questionID': instance.questionID,
      'content': instance.content,
      'date': instance.date.toIso8601String(),
    };
