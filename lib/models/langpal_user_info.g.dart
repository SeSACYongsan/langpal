// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'langpal_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LangpalUserInfoImpl _$$LangpalUserInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$LangpalUserInfoImpl(
      firstLanguage: $enumDecode(_$LanguageEnumMap, json['firstLanguage']),
      targetLanguage: $enumDecode(_$LanguageEnumMap, json['targetLanguage']),
      level: $enumDecode(_$LevelEnumMap, json['level']),
      username: json['username'] as String,
    );

Map<String, dynamic> _$$LangpalUserInfoImplToJson(
        _$LangpalUserInfoImpl instance) =>
    <String, dynamic>{
      'firstLanguage': _$LanguageEnumMap[instance.firstLanguage]!,
      'targetLanguage': _$LanguageEnumMap[instance.targetLanguage]!,
      'level': _$LevelEnumMap[instance.level]!,
      'username': instance.username,
    };

const _$LanguageEnumMap = {
  Language.mandarin: 'mandarin',
  Language.spanish: 'spanish',
  Language.english: 'english',
  Language.hindi: 'hindi',
  Language.bengali: 'bengali',
  Language.portuguese: 'portuguese',
  Language.russian: 'russian',
  Language.japanese: 'japanese',
  Language.vietnamese: 'vietnamese',
  Language.turkish: 'turkish',
  Language.korean: 'korean',
};

const _$LevelEnumMap = {
  Level.beginner: 'beginner',
  Level.intermediate: 'intermediate',
  Level.advanced: 'advanced',
};
