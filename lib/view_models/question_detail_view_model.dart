import 'package:langpal/models/answer.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/fields/answer_text_field_provider.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'question_detail_view_model.g.dart';

@riverpod
class QuestionDetailViewModel extends _$QuestionDetailViewModel {
  late final QuestionRepository questionRepository;
  late final AnswerRepository answerRepository;
  late final UserRepository userRepository;
  Future<void> addAnswer(String questionID) async {
    const uuid = Uuid();
    final content = ref.read(answerTextFieldProvider);
    final currentUser = ref.read(currentUserProvider).value!;
    final answer = Answer(
      id: uuid.v4(),
      ownerID: currentUser.id,
      ownerUsername: currentUser.info.username,
      questionID: questionID,
      content: content,
      date: DateTime.now(),
    );
    answerRepository.addAnswer(answer);
    await fetchQuestionDetail(questionID);
  }

  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    answerRepository = AnswerRepository();
    userRepository = UserRepository();
    return null;
  }

  Future<void> fetchQuestionDetail(String questionID) async {
    try {
      final answers =
          await answerRepository.fetchAnswersByQuestionID(questionID);
      final question = await questionRepository.fetchQuestionByID(questionID);
      final user = await userRepository.fetchUserByQuestionID(questionID);
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
