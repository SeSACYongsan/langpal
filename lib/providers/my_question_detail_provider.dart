import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';

final myQuestionDetailProvider =
    FutureProvider.family<Map<String, dynamic>?, String>(
        (ref, questionID) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final questionReference =
      firestoreInstance.collection("questions").doc(questionID);
  final questionSnapshot = await questionReference.get();
  try {
    if (questionSnapshot.exists) {
      if (questionSnapshot.data() != null) {
        final question = Question.fromMap(questionSnapshot.data()!);
        final questionID = question.id;
        final answers = firestoreInstance.collection("answers");
        final answersReference =
            await answers.where("questionID", isEqualTo: questionID).get();
        final matchingAnswers = answersReference.docs.map((document) {
          if (document.exists) {
            return Answer.fromMap(document.data());
          } else {
            throw Exception("The answer document doesn't exist");
          }
        }).toList();
        return {
          "question": question,
          "answers": matchingAnswers,
        };
      } else {
        throw Exception("The question data is null");
      }
    } else {
      throw Exception("The question snapshot doesn't exist");
    }
  } catch (error) {
    print(error);
  }
  return null;
});
