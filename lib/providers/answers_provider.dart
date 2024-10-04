import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';

final answersProvider =
    AsyncNotifierProvider.family<AnswersNotifier, List<Answer>?, String>(
  () {
    return AnswersNotifier();
  },
);

class AnswersNotifier extends FamilyAsyncNotifier<List<Answer>?, String> {
  @override
  Future<List<Answer>?> build(String questionID) async {
    return await getAnswersByQuestionID(questionID);
  }

  Future<List<Answer>?> getAnswersByQuestionID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answers = firestoreInstance.collection("answers");
    final answersReference = answers.where("questionID", isEqualTo: questionID);
    final answersSnapshot = await answersReference.get();
    final answerDocuments = answersSnapshot.docs;
    try {
      final allAnswers = answerDocuments.map((document) {
        if (document.exists) {
          return Answer.fromMap(document.data());
        } else {
          throw Exception("The document doesn't exist");
        }
      }).toList();
      return allAnswers;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<void> registerAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerReference =
        firestoreInstance.collection("answers").doc(answer.id);
    await answerReference.set(answer.toMap());
  }
}
