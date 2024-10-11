import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  late QuestionRepository questionRepository;
  @override
  Future<List<Question>?> build() async {
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> fetchQuestions() async {
    final questions = await questionRepository.fetchQuestions();
    state = AsyncData(questions);
  }
}
