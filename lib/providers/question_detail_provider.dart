import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_detail_provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> questionDetail(
    QuestionDetailRef ref, String questionID) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final questionReference =
      firestoreInstance.collection("questions").doc(questionID);
  final questionSnapshot = await questionReference.get();
  try {
    if (questionSnapshot.exists) {
      if (questionSnapshot.data() != null) {
        final question = Question.fromMap(questionSnapshot.data()!);
        final ownerID = question.ownerID;
        final userReference =
            firestoreInstance.collection("users").doc(ownerID);
        final userSnapshot = await userReference.get();
        if (userSnapshot.exists) {
          if (userSnapshot.data() != null) {
            final user = LangpalUser.fromMap(userSnapshot.data()!);
            final answers = firestoreInstance.collection("answers");
            final answersSnapshot =
                await answers.where("questionID", isEqualTo: questionID).get();
            final matchingAnswers = answersSnapshot.docs.map((document) {
              if (document.exists) {
                return Answer.fromMap(document.data());
              } else {
                throw Exception("The answer document doesn't exist");
              }
            }).toList();
            matchingAnswers.sort((a, b) {
              return a.date.compareTo(b.date);
            });
            return {
              "question": question,
              "user": user,
              "answers": matchingAnswers
            };
          } else {
            throw Exception("The user doesn't exist");
          }
        } else {
          throw Exception("The user snapshot doesn't exist");
        }
      } else {
        throw Exception("The question is null");
      }
    } else {
      throw Exception("The question snapshot doesn't exist");
    }
  } catch (error) {
    print(error);
  }
  return null;
}
