import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/question.dart';

class QuestionRepository {
  Future<void> addQuestion(Question question) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("questions")
        .doc(question.id)
        .set(question.toJson());
  }

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
      questions.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return questions;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<List<Question>?> fetchQuestionsByUserID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionsSnapshot = await firestoreInstance
        .collection("questions")
        .where("ownerID", isEqualTo: userID)
        .get();
    try {
      final questions = questionsSnapshot.docs.map((document) {
        if (document.exists) {
          return Question.fromJson(document.data());
        } else {
          throw Exception("The question doesn't exist");
        }
      }).toList();
      questions.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return questions;
    } catch (error) {
      print(error);
    }
    return null;
  }
}