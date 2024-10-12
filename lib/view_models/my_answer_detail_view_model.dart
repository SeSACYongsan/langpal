import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answer_detail_view_model.g.dart';

@riverpod
class MyAnswerDetailViewModel extends _$MyAnswerDetailViewModel {
  late final AnswerRepository answerRepository;
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> fetchMyAnswerDetail(String answerID) async {
    final answer = await answerRepository.fetchAnswerByID(answerID);
    final question =
        await questionRepository.fetchQuestionByID(answer!.questionID);
    state = AsyncData({
      "question": question,
      "answer": answer,
    });
  }
}
