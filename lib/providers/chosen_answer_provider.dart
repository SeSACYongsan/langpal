import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chosen_answer_provider.g.dart';

@riverpod
class ChosenAnswer extends _$ChosenAnswer {
  @override
  void build() {}

  Future<void> setChosenAnswer(String answerID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerSnapshot =
        await firestoreInstance.collection("answers").doc(answerID).get();
    try {
      if (answerSnapshot.exists) {
        final answer = Answer.fromJson(answerSnapshot.data()!);
        final questionID = answer.questionID;
        final questionSnapshot = await firestoreInstance
            .collection("questions")
            .doc(questionID)
            .get();
        if (questionSnapshot.exists) {
          final question = Question.fromJson(questionSnapshot.data()!);
          final modifiedQuestion = question.copyWith(chosenAnswerID: answerID);
          await firestoreInstance
              .collection("questions")
              .doc(questionID)
              .set(modifiedQuestion.toJson());
          return;
        } else {
          throw Exception("The question snapshot doesn't exist");
        }
      } else {
        throw Exception("The answer snapshot doesn't exist");
      }
    } catch (error) {
      print(error);
    }
  }
}
