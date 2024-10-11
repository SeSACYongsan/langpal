import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/question.dart';

class QuestionRepository {
  Future<Question?> fetchQuestionByID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionSnapshot =
        await firestoreInstance.collection("questions").doc(questionID).get();
    try {
      if (questionSnapshot.exists) {
        final question = Question.fromJson(questionSnapshot.data()!);
        return question;
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<List<Question>?> fetchQuestions() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionsSnapshot =
        await firestoreInstance.collection("questions").get();
    try {
      final questions = questionsSnapshot.docs.map((document) {
        if (document.exists) {
          return Question.fromJson(document.data());
        } else {
          throw Exception("The question doesn't exist");
        }
      }).toList();
      return questions;
    } catch (error) {
      print(error);
    }
    return null;
  }
}
