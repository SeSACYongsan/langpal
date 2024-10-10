import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/fields/answer_text_field_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'answers_provider.g.dart';

@riverpod
class Answers extends _$Answers {
  Future<void> addAnswerByQuestionID(String questionID) async {
    const uuid = Uuid();
    final content = ref.read(answerTextFieldProvider);
    final currentUser = ref.read(currentUserProvider).value!;
    final id = uuid.v4();
    final newAnswer = Answer(
      id: id,
      ownerID: currentUser.id,
      ownerUsername: currentUser.info.username,
      questionID: questionID,
      content: content,
      date: DateTime.now(),
    );
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("answers")
        .doc(id)
        .set(newAnswer.toJson());
    final answers = await firestoreInstance.collection("answers").get();
    try {
      final allAnswers = answers.docs.map((document) {
        if (document.exists) {
          return Answer.fromJson(document.data());
        } else {
          throw Exception("The answer doesn't exist");
        }
      }).toList();
      allAnswers.sort(
        (a, b) {
          return a.date.compareTo(b.date);
        },
      );
      state = AsyncData(allAnswers);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  @override
  Future<List<Answer>> build() async {
    return [];
  }

  Future<void> fetchAnswersByQuestionID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answersSnapshot = await firestoreInstance
        .collection("answers")
        .where("questionID", isEqualTo: questionID)
        .get();
    try {
      final answers = answersSnapshot.docs.map((document) {
        if (document.exists) {
          return Answer.fromJson(document.data());
        } else {
          throw Exception("The answer doesn't exist");
        }
      }).toList();
      answers.sort(
        (a, b) {
          return a.date.compareTo(b.date);
        },
      );
      state = AsyncData(answers);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
