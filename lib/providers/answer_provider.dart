import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'answer_provider.g.dart';

@riverpod
class Answer extends _$Answer {
  @override
  Future<model.Answer?> build() async {
    return null;
  }

  Future<void> fetchAnswerByID(String answerID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerSnapshot =
        await firestoreInstance.collection("answers").doc(answerID).get();
    try {
      if (answerSnapshot.exists) {
        final answer = model.Answer.fromJson(answerSnapshot.data()!);
        state = AsyncData(answer);
      } else {
        throw Exception("The answer doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
