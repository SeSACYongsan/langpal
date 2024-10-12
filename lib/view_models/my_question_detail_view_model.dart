import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_question_detail_view_model.g.dart';

@riverpod
class MyQuestionDetailViewModel extends _$MyQuestionDetailViewModel {
  late final AnswerRepository answerRepository;
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> fetchMyQuestionDetail(String questionID) async {
    final question = await questionRepository.fetchQuestionByID(questionID);
    final answers = await answerRepository.fetchAnswersByQuestionID(questionID);
    state = AsyncData({
      "question": question,
      "answers": answers,
    });
  }
}
