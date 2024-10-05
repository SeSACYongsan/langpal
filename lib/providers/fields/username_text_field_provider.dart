import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameTextFieldProvider =
    NotifierProvider<UsernameTextFieldNotifier, String>(
        () => UsernameTextFieldNotifier());

class UsernameTextFieldNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setUsername(String string) {
    final regExp = RegExp("[^a-zA-Z0-9]");
    state = string.replaceAll(regExp, "");
  }
}
