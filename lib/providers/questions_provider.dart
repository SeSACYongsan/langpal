import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';

final questionsProvider =
    NotifierProvider<QuestionsNotifier, List<Question>>(() {
  return QuestionsNotifier();
});

class QuestionsNotifier extends Notifier<List<Question>> {
  @override
  List<Question> build() {
    return [];
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
}
