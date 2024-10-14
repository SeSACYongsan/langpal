import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_answer_text_field_provider.g.dart';

@riverpod
class NewAnswerTextField extends _$NewAnswerTextField {
  @override
  String build() {
    return "";
  }

  void initializeNewAnswer() {
    state = "";
  }

  void setContent(String content) {
    state = content;
  }
}
