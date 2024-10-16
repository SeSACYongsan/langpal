import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_edit_view_model.g.dart';

@riverpod
class QuestionEditViewModel extends _$QuestionEditViewModel {
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> fetchQuestionDetailByID(String questionID) async {
    final question = await questionRepository.fetchQuestionByID(questionID);
    final questionType = question!.questionType;
    final content = question.content;
    final point = question.point.toDouble();
    state = AsyncData({
      "question": question,
      "questionType": questionType,
      "content": content,
      "point": point,
    });
  }

  Future<void> setContent(String content) async {
    state = AsyncData({
      "question": state.value!["question"] as Question,
      "questionType": state.value!["questionType"] as QuestionType,
      "content": content,
      "point": state.value!["point"] as double,
    });
  }

  Future<void> setPoint(double point) async {
    state = AsyncData({
      "question": state.value!["question"] as Question,
      "questionType": state.value!["questionType"] as QuestionType,
      "content": state.value!["content"] as String,
      "point": point,
    });
  }

  Future<void> setQuestionType(QuestionType questionType) async {
    state = AsyncData({
      "question": state.value!["question"] as Question,
      "questionType": questionType,
      "content": state.value!["content"] as String,
      "point": state.value!["point"] as double,
    });
  }
}
