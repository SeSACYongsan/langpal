import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/langpal_user.dart';

final userProvider = AsyncNotifierProvider<UserNotifier, LangpalUser?>(() {
  return UserNotifier();
});

class UserNotifier extends AsyncNotifier<LangpalUser?> {
  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<LangpalUser?> getUserByID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final users = firestoreInstance.collection("users");
    final userRef = users.doc(userID);
    final userSnapshot = await userRef.get();
    try {
      if (userSnapshot.exists) {
        print("The user exists");
        final data = userSnapshot.data()!;
        final user = LangpalUser.fromMap(data);
        state = AsyncData(user);
      } else {
        throw Exception("The user doesn't exist");
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
