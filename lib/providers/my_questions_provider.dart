import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/providers/current_user_id_provider.dart';

final myQuestionsProvider = FutureProvider<List<Question>?>((ref) async {
  final currentUserID = ref.read(currentUserIDProvider);
  final firestoreInstance = FirebaseFirestore.instance;
  final questions = firestoreInstance.collection("questions");
  final questionsData =
      await questions.where("ownerID", isEqualTo: currentUserID).get();
  try {
    final matchingQuestions = questionsData.docs.map((document) {
      if (document.exists) {
        return Question.fromMap(document.data());
      } else {
        throw Exception("The question document doesn't exist");
      }
    }).toList();
    matchingQuestions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return matchingQuestions;
  } catch (error) {
    print(error);
  }
  return null;
});
