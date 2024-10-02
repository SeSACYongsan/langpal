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
            content: content);
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
