import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/fields/new_question_text_field_provider.dart';
import 'package:langpal/providers/fields/point_slider_provider.dart';
import 'package:langpal/providers/fields/question_type_dropdown_provider.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'new_question_view_model.g.dart';

@riverpod
class NewQuestionViewModel extends _$NewQuestionViewModel {
  late final QuestionRepository questionRepository;
  Future<void> addQuestion() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final questionType = ref.read(questionTypeDropdownProvider);
    final content = ref.read(newQuestionTextFieldProvider);
    final point = ref.read(pointSliderProvider).toInt();
    final firestoreInstance = FirebaseFirestore.instance;
    final userSnapshot =
        await firestoreInstance.collection("users").doc(currentUser.id).get();
    try {
      if (userSnapshot.exists) {
        final user = LangpalUser.fromJson(userSnapshot.data()!);
        final ownerName = user.info.username;
        const uuid = Uuid();
        final question = Question(
          id: uuid.v4(),
          ownerUsername: ownerName.toString(),
          ownerID: currentUser.id,
          questionType: questionType,
          content: content,
          point: point,
          date: DateTime.now(),
        );
        await questionRepository.addQuestion(question);
        state = const AsyncData(null);
      } else {
        throw Exception("The user doesn't exist");
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  @override
  Future<void> build() async {
    questionRepository = QuestionRepository();
  }
}
