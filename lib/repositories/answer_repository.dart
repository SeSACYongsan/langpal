import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/utils/logger.dart';

class AnswerRepository {
  Future<void> addAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("answers")
        .doc(answer.id)
        .set(answer.toJson());
  }

  Future<Answer?> fetchAnswerByID(String answerID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final foo = firestoreInstance.collection("answers").doc(answerID);
    print("1");
    final answerSnapshot0 =
        firestoreInstance.collection("answers").doc(answerID);
    print("2");
    DocumentSnapshot<Map<String, dynamic>> answerSnapshot;
    try {
      print(answerSnapshot0);
      await answerSnapshot0.set({'jh': 1111});
      print('5');
    } catch (e) {
      print('4');
      print(e);
      return null;
    }

    // print("3");
    // try {
    //   if (answerSnapshot.exists) {
    //     final answer = Answer.fromJson(answerSnapshot.data()!);
    //     return answer;
    //   } else {
    //     throw Exception("The answer doesn't exist");
    //   }
    // } catch (error) {
    //   logger.e(error);
    // }
    return null;
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
      logger.e(error);
    }
    return null;
  }

  Future<List<Answer>?> fetchAnswersByUserID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answersSnapshot = await firestoreInstance
        .collection("answers")
        .where("ownerID", isEqualTo: userID)
        .get();
    try {
      final answers = answersSnapshot.docs.map((document) {
        if (document.exists) {
          return Answer.fromJson(document.data());
        } else {
          throw Exception("The answer doesn't exist");
        }
      }).toList();
      answers.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return answers;
    } catch (error) {
      logger.e(error);
    }
    return null;
  }

  Future<void> updateAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("answers")
        .doc(answer.id)
        .set(answer.toJson());
  }
}
