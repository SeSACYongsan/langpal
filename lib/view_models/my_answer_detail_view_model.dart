import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/providers/fields/new_answer_text_field_provider.dart';
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
      "isEditable": false,
    });
  }

  Future<void> setIsEditable(bool isEditable) async {
    state = AsyncData({
      "question": state.value!["question"],
      "answer": state.value!["answer"],
      "isEditable": isEditable,
    });
  }

  Future<void> updateAnswerByAnswerID(String answerID) async {
    final newContent = ref.read(newAnswerTextFieldProvider);
    final firestoreInstance = FirebaseFirestore.instance;
    final answerSnapshot =
        await firestoreInstance.collection("answers").doc(answerID).get();
    try {
      if (answerSnapshot.exists) {
        final answer = Answer.fromJson(answerSnapshot.data()!);
        final modifiedAnswer = answer.copyWith(content: newContent);
        firestoreInstance
            .collection("answers")
            .doc(answerID)
            .set(modifiedAnswer.toJson());
        state = AsyncData({
          "question": state.value!["question"],
          "answer": modifiedAnswer,
          "isEditable": state.value!["isEditable"],
        });
      } else {
        throw Exception("The answer doesn't exist");
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
