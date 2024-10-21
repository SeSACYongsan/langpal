import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/view_models/my_question_detail_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_questions_view_model.g.dart';

@riverpod
class MyQuestionsViewModel extends _$MyQuestionsViewModel {
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    ref.listen(myQuestionDetailViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchMyQuestions();
      }
    });
    questionRepository = QuestionRepository();
    return null;
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
