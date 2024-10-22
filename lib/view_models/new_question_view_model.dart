import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'new_question_view_model.g.dart';

@riverpod
class NewQuestionViewModel extends _$NewQuestionViewModel {
  late final QuestionRepository questionRepository;
  late final UserRepository userRepository;
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
      point: point,
      date: DateTime.now(),
    );
    await questionRepository.addQuestion(question);
  }

  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    userRepository = UserRepository();
    return null;
  }

  void resetState() {
    updateState(
      questionType: QuestionType.what,
      content: "",
      point: 50.0,
    );
  }

  void setContent(String content) {
    updateState(content: content);
  }

  void setPoint(double point) {
    updateState(point: point);
  }

  void setQuestionType(QuestionType questionType) {
    updateState(questionType: questionType);
  }

  Future<void> updatePoint(double amount) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final initialPoint = currentUser.point;
    final modifiedCurrentUser =
        currentUser.copyWith(point: initialPoint + amount.toInt());
    await ref
        .read(currentUserProvider.notifier)
        .setCurrentUser(modifiedCurrentUser);
    await userRepository.updateUser(modifiedCurrentUser);
  }

  void updateState({
    QuestionType? questionType,
    String? content,
    double? point,
  }) {
    state = AsyncData({
      "questionType":
          questionType ?? state.value!["questionType"] as QuestionType,
      "content": content ?? state.value!["content"] as String,
      "point": point ?? state.value!["point"] as double,
    });
  }
}
