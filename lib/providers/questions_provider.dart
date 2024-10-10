import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'questions_provider.g.dart';

@Riverpod(keepAlive: true)
class Questions extends _$Questions {
  @override
  Future<List<Question>?> build() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = await firestoreInstance.collection("questions").get();
    final allQuestions = questions.docs.map((doc) {
      final data = doc.data();
      final question = Question.fromJson(data);
      return question;
    }).toList();
    allQuestions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    final filteredQuestions = allQuestions.where(
      (question) {
        return question.chosenAnswerID == null;
      },
    ).toList();
    return filteredQuestions;
  }

  Future<void> saveQuestion(Question question) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionReference = questions.doc(question.id);
    await questionReference.set(question.toJson());
    state = AsyncData([...state.value!, question]);
  }

  Future<void> setChosenAnswer(String answerID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerSnapshot =
        await firestoreInstance.collection("answers").doc(answerID).get();
    try {
      if (answerSnapshot.exists) {
        final answer = Answer.fromJson(answerSnapshot.data()!);
        final questionID = answer.questionID;
        final questionSnapshot = await firestoreInstance
            .collection("questions")
            .doc(questionID)
            .get();
        if (questionSnapshot.exists) {
          final targetQuestion = Question.fromJson(questionSnapshot.data()!);
          final modifiedQuestion =
              targetQuestion.copyWith(chosenAnswerID: answerID);
          firestoreInstance
              .collection("questions")
              .doc(questionID)
              .set(modifiedQuestion.toJson());
          final modifiedState = state.value!.map((question) {
            if (question.id == modifiedQuestion.id) {
              return modifiedQuestion;
            } else {
              return question;
            }
          }).where((question) {
            return question.chosenAnswerID == null;
          }).toList();
          state = AsyncData(modifiedState);
        } else {
          throw Exception("The question snapshot doesn't exist");
        }
      } else {
        throw Exception("The answer snapshot doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
