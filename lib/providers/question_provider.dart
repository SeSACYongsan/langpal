import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';

final questionProvider =
    AsyncNotifierProvider.family<QuestionNotifier, Question?, String>(() {
  return QuestionNotifier();
});

class QuestionNotifier extends FamilyAsyncNotifier<Question?, String> {
  @override
  Future<Question?> build(String questionID) async {
    final question = await getQuestionByID(questionID);
    return question;
  }

  Future<Question?> getQuestionByID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionRef = questions.doc(questionID);
    final snapshot = await questionRef.get();
    if (snapshot.exists) {
      if (snapshot.data() != null) {
        final data = snapshot.data()!;
        final ownerID = data["ownerID"] as String;
        final point = data["point"] as int;
        final questionTypeString = data["questionType"] as String;
        final questionType = QuestionType.values.byName(questionTypeString);
        final content = data["content"] as String;
        final question = Question(
          id: questionID,
          ownerID: ownerID,
          point: point,
          questionType: questionType,
          content: content,
        );
        return question;
      } else {
        print("The question snapshot is null");
        return null;
      }
    } else {
      print("The question doesn't exist");
      return null;
    }
  }
}
