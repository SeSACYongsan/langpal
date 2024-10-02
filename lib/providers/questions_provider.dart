import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';

final questionsProvider =
    AsyncNotifierProvider<QuestionsNotifier, List<Question>>(() {
  return QuestionsNotifier();
});

class QuestionsNotifier extends AsyncNotifier<List<Question>> {
  @override
  Future<List<Question>> build() {
    return getQuestions();
  }

  Future<List<Question>> getQuestions() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = await firestoreInstance.collection("questions").get();
    final allQuestions = questions.docs.map((doc) {
      final data = doc.data();
      final id = data["id"] as String;
      final ownerID = data["ownerID"] as String;
      final point = data["point"] as int;
      final questionTypeString = data["questionType"] as String;
      final questionType = QuestionType.values.byName(questionTypeString);
      final content = data["content"] as String;
      final question = Question(
          id: id,
          ownerID: ownerID,
          point: point,
          questionType: questionType,
          content: content);
      return question;
    }).toList();
    return allQuestions;
  }

  Future<void> saveQuestion(Question question) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionRef = questions.doc(question.id);
    await questionRef.set({
      "id": question.id,
      "ownerID": question.ownerID,
      "point": question.point,
      "questionType": question.questionType.name,
      "content": question.content,
    });
    final data = state.value!;
    state = AsyncValue.data([...data, question]);
  }
}
