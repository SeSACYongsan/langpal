import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/providers/current_user_id_provider.dart';

final myAnswersProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final currentUserID = ref.read(currentUserIDProvider);
  final firestoreInstance = FirebaseFirestore.instance;
  final answers = await firestoreInstance
      .collection("answers")
      .where("ownerID", isEqualTo: currentUserID)
      .get();
  try {
    final matchingAnswers = answers.docs.map((document) {
      if (document.exists) {
        return Answer.fromMap(document.data());
      } else {
        throw Exception("The answer document doesn't exist");
      }
    }).toList();
    matchingAnswers.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    final userSnapshot =
        await firestoreInstance.collection("users").doc(currentUserID).get();
    if (userSnapshot.exists) {
      final user = LangpalUser.fromMap(userSnapshot.data()!);
      return {
        "answers": matchingAnswers,
        "user": user,
      };
    } else {
      throw Exception("The user snapshot doesn't exist");
    }
  } catch (error) {
    print(error);
  }
  return null;
});
