import 'dart:typed_data';

import 'package:langpal/models/notification.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/notification_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'my_question_detail_view_model.g.dart';

@riverpod
class MyQuestionDetailViewModel extends _$MyQuestionDetailViewModel {
  late final AnswerRepository answerRepository;
  late final QuestionRepository questionRepository;
  late final NotificationRepository notificationRepository;
  late final UserRepository userRepository;
  Future<void> addNotification(String answerID) async {
    const uuid = Uuid();
    final answer = await answerRepository.fetchAnswerByID(answerID);
    final ownerID = answer!.ownerID;
    final notification = Notification(
      id: uuid.v4(),
      ownerID: ownerID,
      date: DateTime.now(),
      content: "답변이 채택되었습니다",
    );
    await notificationRepository.addNotification(notification);
  }

  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    questionRepository = QuestionRepository();
    notificationRepository = NotificationRepository();
    userRepository = UserRepository();
    return null;
  }

  Future<void> deleteQuestionByID(String questionID) async {
    await questionRepository.deleteQuestionByID(questionID);
    await answerRepository.deleteAnswersByQuestionID(questionID);
    await fetchMyQuestionDetail(questionID);
  }

  Future<void> fetchMyQuestionDetail(String questionID) async {
    final question = await questionRepository.fetchQuestionByID(questionID);
    final answers = await answerRepository.fetchAnswersByQuestionID(questionID);
    final answerOwnerIDs = answers!.map((answer) => answer.ownerID);
    final answerOwnerIDSet = Set.from(answerOwnerIDs);
    Map<String, Uint8List?> answerOwnerProfilePhotoMap = {};
    List<Uint8List?> answerOwnerProfilePhotos = [];
    for (final answerOwnerID in answerOwnerIDSet) {
      final profilePhoto =
          await userRepository.fetchProfilePhotoByUserID(answerOwnerID);
      answerOwnerProfilePhotoMap[answerOwnerID] = profilePhoto;
    }
    for (final answerOwnerID in answerOwnerIDs) {
      answerOwnerProfilePhotos.add(answerOwnerProfilePhotoMap[answerOwnerID]);
    }
    state = AsyncData({
      "question": question,
      "answers": answers,
      "answerOwnerProfilePhotos": answerOwnerProfilePhotos,
    });
  }

  Future<void> setChosenAnswer({
    required String questionID,
    required String answerID,
  }) async {
    await questionRepository.setChosenAnswerByAnswerID(answerID);
    await fetchMyQuestionDetail(questionID);
  }
}
