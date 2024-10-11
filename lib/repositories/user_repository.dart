import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';

class UserRepository {
  Future<LangpalUser?> fetchUserByQuestionID(String questionID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final questionSnapshot =
        await firestoreInstance.collection("questions").doc(questionID).get();
    try {
      if (questionSnapshot.exists) {
        final question = Question.fromJson(questionSnapshot.data()!);
        final userID = question.ownerID;
        final userSnapshot =
            await firestoreInstance.collection("users").doc(userID).get();
        if (userSnapshot.exists) {
          final user = LangpalUser.fromJson(userSnapshot.data()!);
          return user;
        } else {
          throw Exception("The user doesn't exist");
        }
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
