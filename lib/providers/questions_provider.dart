import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'questions_provider.g.dart';

@Riverpod(keepAlive: true)
class Questions extends _$Questions {
  @override
  List<Question> build() {
    return [];
  }

  Future<void> getQuestions() async {
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
        if (question.chosenAnswerID != null) {
          return false;
        } else {
          return true;
        }
      },
    ).toList();
    state = filteredQuestions;
  }

  Future<void> saveQuestion(Question question) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questions = firestoreInstance.collection("questions");
    final questionReference = questions.doc(question.id);
    await questionReference.set(question.toJson());
    final data = state;
    state = [...data, question];
  }
}
