import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answer_detail_provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> myAnswerDetail(
    MyAnswerDetailRef ref, String answerID) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final answerSnapshot =
      await firestoreInstance.collection("answers").doc(answerID).get();
  try {
    if (answerSnapshot.exists) {
      final answer = Answer.fromJson(answerSnapshot.data()!);
      final questionSnapshot = await firestoreInstance
          .collection("questions")
          .doc(answer.questionID)
          .get();
      if (questionSnapshot.exists) {
        final question = Question.fromJson(questionSnapshot.data()!);
        return {
          "question": question,
          "answer": answer,
        };
      } else {
        throw Exception("The question snapshot doesn't exist");
      }
    } else {
      throw Exception("The answer snapshot doesn't exist");
    }
  } catch (error) {
    print(error);
  }
  return null;
}
