import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_detail_view_model.g.dart';

@riverpod
class QuestionDetailViewModel extends _$QuestionDetailViewModel {
  late final QuestionRepository questionRepository;
  late final AnswerRepository answerRepository;
  late final UserRepository userRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    answerRepository = AnswerRepository();
    userRepository = UserRepository();
    return null;
  }

  Future<void> fetchQuestionDetail(String questionID) async {
    try {
      final results = await Future.wait([
        answerRepository.fetchAnswersByQuestionID(questionID),
        questionRepository.fetchQuestionByID(questionID),
        userRepository.fetchUserByQuestionID(questionID),
      ]);
      final answers = results[0] as List<Answer>?;
      final question = results[1] as Question?;
      final user = results[2] as LangpalUser?;
      if (answers == null || question == null || user == null) {
        throw Exception("Failed to fetch data");
      }
      state = AsyncData({
        "answers": answers,
        "question": question,
        "user": user,
      });
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
