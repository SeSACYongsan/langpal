import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_question_text_field_provider.g.dart';

@riverpod
class NewQuestionTextField extends _$NewQuestionTextField {
  @override
  String build() {
    return "";
  }

  void initializeNewQuestion() {
    state = "";
  }

  void setString(String string) {
    state = string;
  }
}
