import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';

part 'langpal_user_info.freezed.dart';
part 'langpal_user_info.g.dart';

@freezed
class LangpalUserInfo with _$LangpalUserInfo {
  factory LangpalUserInfo({
    required Language firstLanguage,
    required Language targetLanguage,
    required Level level,
    required String username,
  }) = _LangpalUserInfo;
  factory LangpalUserInfo.fromJson(Map<String, dynamic> json) =>
      _$LangpalUserInfoFromJson(json);
}
