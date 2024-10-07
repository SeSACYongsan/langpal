import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';

final answersProvider =
    AsyncNotifierProvider<AnswersNotifier, List<Answer>>(() {
  return AnswersNotifier();
});

class AnswersNotifier extends AsyncNotifier<List<Answer>> {
  @override
  Future<List<Answer>> build() async {
    return [];
  }

  Future<void> getAnswersByQuestionID(String questionID) async {
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
      allAnswers.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      state = AsyncData(allAnswers);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
