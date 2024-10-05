import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';

final questionProvider = AsyncNotifierProvider<QuestionNotifier, Question?>(() {
  return QuestionNotifier();
});

class QuestionNotifier extends AsyncNotifier<Question?> {
  @override
  Future<Question?> build() async {
    return null;
  }

  Future<void> getQuestionByID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionRef = questions.doc(questionID);
    final snapshot = await questionRef.get();
    try {
      if (snapshot.exists) {
        if (snapshot.data() != null) {
          final data = snapshot.data()!;
          final question = Question.fromMap(data);
          print(question);
          state = AsyncData(question);
        } else {
          throw Exception("The question snapshot is null");
        }
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      print(error);
    }
  }
}
