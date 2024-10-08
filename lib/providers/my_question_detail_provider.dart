import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';

final myQuestionDetailProvider = AsyncNotifierProvider.family<
    MyQuestionDetailNotifier, Map<String, dynamic>?, String>(() {
  return MyQuestionDetailNotifier();
});

class MyQuestionDetailNotifier
    extends FamilyAsyncNotifier<Map<String, dynamic>?, String> {
  @override
  build(String questionID) async {
    return await getQuestionDetail(questionID);
  }

  Future<Map<String, dynamic>?> getQuestionDetail(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionReference =
        firestoreInstance.collection("questions").doc(questionID);
    final questionSnapshot = await questionReference.get();
    try {
      if (questionSnapshot.exists) {
        if (questionSnapshot.data() != null) {
          final question = Question.fromMap(questionSnapshot.data()!);
          final questionID = question.id;
          final answers = firestoreInstance.collection("answers");
          final answersReference =
              await answers.where("questionID", isEqualTo: questionID).get();
          final matchingAnswers = answersReference.docs.map((document) {
            if (document.exists) {
              return Answer.fromMap(document.data());
            } else {
              throw Exception("The answer document doesn't exist");
            }
          }).toList();
          matchingAnswers.sort((a, b) {
            return a.date.compareTo(b.date);
          });
          final chosenAnswerID = question.chosenAnswerID;
          return {
            "question": question,
            "answers": matchingAnswers,
            "chosenAnswerID": chosenAnswerID,
          };
        } else {
          throw Exception("The question data is null");
        }
      } else {
        throw Exception("The question snapshot doesn't exist");
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
