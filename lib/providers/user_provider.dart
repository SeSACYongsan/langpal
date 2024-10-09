import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<void> getUserByID(String userID) async {
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
}
