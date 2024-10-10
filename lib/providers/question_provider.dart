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

  Future<void> fetchQuestionByID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionSnapshot =
        await firestoreInstance.collection("questions").doc(questionID).get();
    try {
      if (questionSnapshot.exists) {
        final question = model.Question.fromJson(questionSnapshot.data()!);
        state = AsyncData(question);
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
