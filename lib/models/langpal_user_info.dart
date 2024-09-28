import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';

class LangpalUserInfo {
  final Language firstLanguage;
  final Language targetLanguage;
  final Level level;
  final String username;
  LangpalUserInfo(
      {required this.firstLanguage,
      required this.targetLanguage,
      required this.level,
      required this.username});
}
