import 'dart:typed_data';

import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/notification.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/notification_repository.dart';
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
  late final NotificationRepository notificationRepository;
  Future<void> addAnswer(String questionID) async {
    const uuid = Uuid();
    final content = state.value!["answer"] as String;
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
    const uuid = Uuid();
    if (ownerID != currentUser.id) {
      final notification = Notification(
        id: uuid.v4(),
        ownerID: ownerID,
        date: DateTime.now(),
        content: "질문에 답변이 등록되었습니다",
      );
      await notificationRepository.addNotification(notification);
    }
  }

  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    answerRepository = AnswerRepository();
    userRepository = UserRepository();
    notificationRepository = NotificationRepository();
    return null;
  }

  Future<void> deleteQuestionByID(String questionID) async {
    await questionRepository.deleteQuestionByID(questionID);
    await answerRepository.deleteAnswersByQuestionID(questionID);
    state = const AsyncData(null);
  }

  Future<void> fetchQuestionDetail(String questionID) async {
    try {
      final answers =
          await answerRepository.fetchAnswersByQuestionID(questionID);
      final question = await questionRepository.fetchQuestionByID(questionID);
      final questionOwner =
          await userRepository.fetchUserByQuestionID(questionID);
      List<LangpalUser?> answerOwners = [];
      for (final answer in answers!) {
        final owner = await userRepository.fetchUserByID(answer.ownerID);
        answerOwners.add(owner);
      }
      final profilePhoto =
          await userRepository.fetchProfilePhotoByUserID(question!.ownerID);
      state = AsyncData({
        "answers": answers,
        "question": question,
        "questionOwner": questionOwner,
        "answerOwners": answerOwners,
        "answer": "",
        "profilePhoto": profilePhoto,
      });
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  void resetAnswer() {
    state = AsyncData({
      "answers": state.value!["answers"] as List<Answer>,
      "question": state.value!["question"] as Question,
      "questionOwner": state.value!["questionOwner"] as LangpalUser,
      "answerOwners": state.value!["answerOwners"] as List<LangpalUser?>,
      "answer": "",
      "profilePhoto": state.value!["profilePhoto"] as Uint8List?,
    });
  }

  void setAnswer(String answer) {
    state = AsyncData({
      "answers": state.value!["answers"] as List<Answer>,
      "question": state.value!["question"] as Question,
      "questionOwner": state.value!["questionOwner"] as LangpalUser,
      "answerOwners": state.value!["answerOwners"] as List<LangpalUser?>,
      "answer": answer,
      "profilePhoto": state.value!["profilePhoto"] as Uint8List?,
    });
  }
}
