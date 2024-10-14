import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/notification.dart';
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

  Future<void> addNotificationByQuestionID(String questionID) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final question = await questionRepository.fetchQuestionByID(questionID);
    final ownerID = question!.ownerID;
    final firestoreInstance = FirebaseFirestore.instance;
    const uuid = Uuid();
    if (ownerID != currentUser.id) {
      final notification = Notification(
        id: uuid.v4(),
        ownerID: ownerID,
        date: DateTime.now(),
        content: "질문에 답변이 등록되었습니다",
      );
      await firestoreInstance
          .collection("notifications")
          .doc(notification.id)
          .set(notification.toJson());
    }
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
      final questionOwner =
          await userRepository.fetchUserByQuestionID(questionID);
      state = AsyncData({
        "answers": answers,
        "question": question,
        "questionOwner": questionOwner,
      });
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
