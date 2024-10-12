import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';

class AnswerRepository {
  Future<void> addAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("answers")
        .doc(answer.id)
        .set(answer.toJson());
  }

  Future<List<Answer>?> fetchAnswersByQuestionID(String questionID) async {
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
      return answers;
    } catch (error) {
      print(error);
    }
    return null;
  }
}