import 'package:langpal/models/notification.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/notification_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'my_question_detail_view_model.g.dart';

@riverpod
class MyQuestionDetailViewModel extends _$MyQuestionDetailViewModel {
  late final AnswerRepository answerRepository;
  late final QuestionRepository questionRepository;
  late final NotificationRepository notificationRepository;
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

  Future<void> setChosenAnswer({
    required String questionID,
    required String answerID,
  }) async {
    await questionRepository.setChosenAnswerByAnswerID(answerID);
    await fetchMyQuestionDetail(questionID);
  }
}
