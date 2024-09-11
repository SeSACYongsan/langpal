import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';

final questionTypeProvider =
    StateNotifierProvider<QuestionTypeNotifier, QuestionType>(
        (ref) => QuestionTypeNotifier());

class QuestionTypeNotifier extends StateNotifier<QuestionType> {
  QuestionTypeNotifier() : super(QuestionType.what);
  void setQuestionType(QuestionType questionType) {
    state = questionType;
  }
}
