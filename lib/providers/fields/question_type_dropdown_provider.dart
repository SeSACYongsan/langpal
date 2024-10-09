import 'package:langpal/models/question_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_type_dropdown_provider.g.dart';

@riverpod
class QuestionTypeDropdown extends _$QuestionTypeDropdown {
  @override
  QuestionType build() {
    return QuestionType.meaning;
  }

  void initializeQuestionType() {
    state = QuestionType.meaning;
  }

  void setQuestionType(QuestionType questionType) {
    state = questionType;
  }
}
