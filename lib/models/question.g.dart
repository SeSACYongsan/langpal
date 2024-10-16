// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      ownerUsername: json['ownerUsername'] as String,
      ownerID: json['ownerID'] as String,
      point: (json['point'] as num).toDouble(),
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      chosenAnswerID: json['chosenAnswerID'] as String?,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerUsername': instance.ownerUsername,
      'ownerID': instance.ownerID,
      'point': instance.point,
      'questionType': _$QuestionTypeEnumMap[instance.questionType]!,
      'content': instance.content,
      'date': instance.date.toIso8601String(),
      'chosenAnswerID': instance.chosenAnswerID,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.meaning: 'meaning',
  QuestionType.isNatural: 'isNatural',
  QuestionType.what: 'what',
  QuestionType.difference: 'difference',
  QuestionType.examples: 'examples',
};
