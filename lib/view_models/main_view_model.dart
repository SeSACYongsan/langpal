import 'package:langpal/models/question.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/view_models/my_question_detail_view_model.dart';
import 'package:langpal/view_models/new_question_view_model.dart';
import 'package:langpal/view_models/question_detail_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  late final QuestionRepository questionRepository;
  @override
  Future<List<Question>?> build() async {
    questionRepository = QuestionRepository();
    ref.listen(newQuestionViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchUnchosenQuestions();
      }
    });
    ref.listen(myQuestionDetailViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchUnchosenQuestions();
      }
    });
    ref.listen(questionDetailViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchUnchosenQuestions();
      }
    });
    return null;
  }

  Future<void> fetchUnchosenQuestions() async {
    final questions = await questionRepository.fetchUnchosenQuestions();
    state = AsyncData(questions);
  }
}
