import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';

class LangpalUserInfo {
  final Language firstLanguage;
  final Language targetLanguage;
  final Level level;
  final String username;
  LangpalUserInfo({
    required this.firstLanguage,
    required this.targetLanguage,
    required this.level,
    required this.username,
  });
  factory LangpalUserInfo.fromMap(Map<String, dynamic> map) {
    return LangpalUserInfo(
      firstLanguage: Language.values.byName(map["firstLanguage"]!),
      targetLanguage: Language.values.byName(map["targetLanguage"]!),
      level: Level.values.byName(map["level"]!),
      username: map["username"]!,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "firstLanguage": firstLanguage.name,
      "targetLanguage": targetLanguage.name,
      "level": level.name,
      "username": username,
    };
  }
}
