import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'answers_provider.g.dart';

@riverpod
class Answers extends _$Answers {
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
          return Answer.fromJson(document.data());
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
