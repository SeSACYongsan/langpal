import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'answer_text_field_provider.g.dart';

@riverpod
class AnswerTextField extends _$AnswerTextField {
  @override
  String build() {
    return "";
  }

  void initializeAnswer() {
    state = "";
  }

  void setAnswer(String answer) {
    state = answer;
  }
}
