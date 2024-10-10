import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_provider.g.dart';

@riverpod
class Question extends _$Question {
  @override
  Future<model.Question?> build() async {
    return null;
  }

  Future<void> fetchQuestionByAnswerID(String answerID) async {
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
          final question = model.Question.fromJson(questionSnapshot.data()!);
          state = AsyncData(question);
        } else {
          throw Exception("The question doesn't exist");
        }
      } else {
        throw Exception("The answer doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
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
