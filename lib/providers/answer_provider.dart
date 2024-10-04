import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';

final answerProvider = NotifierProvider<AnswerNotifier, Answer?>(
  () {
    return AnswerNotifier();
  },
);

class AnswerNotifier extends Notifier<Answer?> {
  @override
  build() {
    return null;
  }

  Future<void> registerAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerReference =
        firestoreInstance.collection("answers").doc(answer.id);
    await answerReference.set(answer.toMap());
  }
}
