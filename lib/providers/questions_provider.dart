import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';

final questionsProvider =
    NotifierProvider<QuestionsNotifier, List<Question>>(() {
  return QuestionsNotifier();
});

class QuestionsNotifier extends Notifier<List<Question>> {
  @override
  List<Question> build() {
    return [];
  }

  Future<void> getQuestions() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = await firestoreInstance.collection("questions").get();
    final allQuestions = questions.docs.map((doc) {
      final data = doc.data();
      final question = Question.fromMap(data);
      return question;
    }).toList();
    allQuestions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    state = allQuestions;
  }

  Future<void> saveQuestion(Question question) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionReference = questions.doc(question.id);
    await questionReference.set(question.toMap());
    final data = state;
    state = [...data, question];
  }
}
