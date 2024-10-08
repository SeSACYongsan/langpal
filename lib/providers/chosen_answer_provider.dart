import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';

final chosenAnswerProvider =
    FutureProvider.family<void, String>((ref, answerID) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final answerSnapshot =
      await firestoreInstance.collection("answers").doc(answerID).get();
  try {
    if (answerSnapshot.exists) {
      final answer = Answer.fromMap(answerSnapshot.data()!);
      final questionID = answer.questionID;
      final questionSnapshot =
          await firestoreInstance.collection("questions").doc(questionID).get();
      if (questionSnapshot.exists) {
        final question = Question.fromMap(questionSnapshot.data()!);
        question.chosenAnswerID = answerID;
        await firestoreInstance
            .collection("questions")
            .doc(questionID)
            .set(question.toMap());
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
});
