import 'package:langpal/models/langpal_user_info.dart';

class LangpalUser {
  final String displayName;
  final String emailAddress;
  final String userID;
  final LangpalUserInfo info;
  LangpalUser(
      {required this.userID,
      required this.displayName,
      required this.emailAddress,
      required this.info});
}
