import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<void> fetchUserByID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final users = firestoreInstance.collection("users");
    final userReference = users.doc(userID);
    final userSnapshot = await userReference.get();
    try {
      if (userSnapshot.exists) {
        print("The user exists");
        final data = userSnapshot.data()!;
        final user = LangpalUser.fromJson(data);
        state = AsyncData(user);
      } else {
        throw Exception("The user doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> fetchUserByQuestionID(String questionID) async {
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
          state = AsyncData(user);
        } else {
          throw Exception("The user doesn't exist");
        }
      } else {
        throw Exception("The question doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}
