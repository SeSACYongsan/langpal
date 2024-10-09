import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'username_text_field_provider.g.dart';

@riverpod
class UsernameTextField extends _$UsernameTextField {
  @override
  String build() {
    return "";
  }

  void setUsername(String string) {
    final regExp = RegExp("[^a-zA-Z0-9]");
    state = string.replaceAll(regExp, "");
  }
}
