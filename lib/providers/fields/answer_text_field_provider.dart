import 'package:flutter_riverpod/flutter_riverpod.dart';

final answerTextFieldProvider =
    NotifierProvider<AnswerTextFieldNotifier, String>(
  () {
    return AnswerTextFieldNotifier();
  },
);

class AnswerTextFieldNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setAnswer(String answer) {
    state = answer;
  }
}
