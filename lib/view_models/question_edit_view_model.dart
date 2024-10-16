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
      "questionType": questionType,
      "content": content,
      "point": point,
    });
  }

  void resetState() {
    updateState(
      questionType: QuestionType.what,
      content: "",
      point: 50.0,
    );
  }

  void setContent(String content) {
    updateState(content: content);
  }

  void setPoint(double point) {
    updateState(point: point);
  }

  void setQuestionType(QuestionType questionType) {
    updateState(questionType: questionType);
  }

  Future<void> submitQuestionByQuestionID(String questionID) async {
    final question = await questionRepository.fetchQuestionByID(questionID);
    final questionType = state.value!["questionType"] as QuestionType;
    final content = state.value!["content"] as String;
    final point = state.value!["point"] as double;
    final modifiedQuestion = question!
        .copyWith(questionType: questionType, content: content, point: point);
    await questionRepository.updateQuestion(modifiedQuestion);
  }

  void updateState(
      {QuestionType? questionType, String? content, double? point}) {
    state = AsyncData({
      "questionType":
          questionType ?? state.value!["questionType"] as QuestionType,
      "content": content ?? state.value!["content"] as String,
      "point": point ?? state.value!["point"] as double,
    });
  }
}
