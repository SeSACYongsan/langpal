import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:langpal/models/langpal_user_info.dart';

part 'langpal_user.freezed.dart';
part 'langpal_user.g.dart';

@freezed
class LangpalUser with _$LangpalUser {
  factory LangpalUser({
    required String userID,
    required String displayName,
    required String emailAddress,
    required LangpalUserInfo info,
    required bool isPremium,
    required int point,
  }) = _LangpalUser;
  factory LangpalUser.fromJson(Map<String, dynamic> json) =>
      _$LangpalUserFromJson(json);
}
