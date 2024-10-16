import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'new_question_view_model.g.dart';

@riverpod
class NewQuestionViewModel extends _$NewQuestionViewModel {
  late final QuestionRepository questionRepository;
  Future<void> addQuestion() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final questionType = state.value!["questionType"] as QuestionType;
    final content = state.value!["content"] as String;
    final point = state.value!["point"] as double;
    final ownerUsername = currentUser.info.username;
    const uuid = Uuid();
    final question = Question(
      id: uuid.v4(),
      ownerUsername: ownerUsername.toString(),
      ownerID: currentUser.id,
      questionType: questionType,
      content: content,
      point: point.toInt(),
      date: DateTime.now(),
    );
    await questionRepository.addQuestion(question);
  }

  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> resetFields() async {
    state = const AsyncData({
      "questionType": QuestionType.what,
      "content": "",
      "point": 50.0,
    });
  }

  Future<void> setContent(String content) async {
    state = AsyncData({
      "questionType": state.value!["questionType"] as QuestionType,
      "content": content,
      "point": state.value!["point"] as double,
    });
  }

  Future<void> setPoint(double point) async {
    state = AsyncData({
      "questionType": state.value!["questionType"] as QuestionType,
      "content": state.value!["content"] as String,
      "point": point,
    });
  }

  Future<void> setQuestionType(QuestionType questionType) async {
    state = AsyncData({
      "questionType": questionType,
      "content": state.value!["content"] as String,
      "point": state.value!["point"] as double,
    });
  }
}
