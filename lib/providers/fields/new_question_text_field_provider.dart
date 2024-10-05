import 'package:flutter_riverpod/flutter_riverpod.dart';

final newQuestionTextFieldProvider =
    NotifierProvider<NewQuestionTextFieldNotifier, String>(
        () => NewQuestionTextFieldNotifier());

class NewQuestionTextFieldNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setString(String string) {
    state = string;
  }
}
