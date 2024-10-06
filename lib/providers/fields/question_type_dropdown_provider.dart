import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';

final questionTypeDropdownProvider =
    NotifierProvider<QuestionTypeDropdownNotifier, QuestionType>(
        () => QuestionTypeDropdownNotifier());

class QuestionTypeDropdownNotifier extends Notifier<QuestionType> {
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
