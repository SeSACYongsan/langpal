import 'package:langpal/models/question.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/view_models/new_question_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  late QuestionRepository questionRepository;
  @override
  Future<List<Question>?> build() async {
    questionRepository = QuestionRepository();
    ref.listen(newQuestionViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchQuestions();
      }
    });
    return null;
  }

  Future<void> fetchQuestions() async {
    final questions = await questionRepository.fetchQuestions();
    state = AsyncData(questions);
  }
}
