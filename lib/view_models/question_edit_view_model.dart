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

  Future<void> fetchQuestionByID(String questionID) async {
    final question = await questionRepository.fetchQuestionByID(questionID);
    state = AsyncData({
      "question": question,
    });
  }
}
