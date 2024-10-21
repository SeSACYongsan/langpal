import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_questions_view_model.g.dart';

@riverpod
class MyQuestionsViewModel extends _$MyQuestionsViewModel {
  late final QuestionRepository questionRepository;
  late final AnswerRepository answerRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> deleteQuestionByID(String questionID) async {
    await questionRepository.deleteQuestionByID(questionID);
    await answerRepository.deleteAnswersByQuestionID(questionID);
    await fetchMyQuestions();
  }

  Future<void> fetchMyQuestions() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final userID = currentUser.id;
    final questions = await questionRepository.fetchQuestionsByUserID(userID);
    state = AsyncData({
      "questions": questions,
    });
  }
}
