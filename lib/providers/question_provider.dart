import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/question.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_provider.g.dart';

@riverpod
class Question extends _$Question {
  @override
  Future<model.Question?> build() async {
    return null;
  }

  Future<void> getQuestionByID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionReference = questions.doc(questionID);
    final snapshot = await questionReference.get();
    try {
      if (snapshot.exists) {
        if (snapshot.data() != null) {
          final data = snapshot.data()!;
          final question = model.Question.fromMap(data);
          print(question);
          state = AsyncData(question);
        } else {
          throw Exception("The question snapshot is null");
        }
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
