import 'package:langpal/models/langpal_user_info.dart';

class LangpalUser {
  final String displayName;
  final String emailAddress;
  final String userID;
  final LangpalUserInfo info;
  LangpalUser({
    required this.userID,
    required this.displayName,
    required this.emailAddress,
    required this.info,
  });
  factory LangpalUser.fromMap(Map<String, dynamic> map) {
    return LangpalUser(
      userID: map["userID"],
      displayName: map["displayName"],
      emailAddress: map["emailAddress"],
      info: LangpalUserInfo.fromMap(map["info"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "displayName": displayName,
      "emailAddress": emailAddress,
      "userID": userID,
      "info": info.toMap()
    };
  }
}
