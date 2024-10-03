import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/langpal_user.dart';

final userProvider =
    AsyncNotifierProvider.family<UserNotifier, LangpalUser?, String>(() {
  return UserNotifier();
});

class UserNotifier extends FamilyAsyncNotifier<LangpalUser?, String> {
  @override
  Future<LangpalUser?> build(String userID) async {
    final user = await getUserByID(userID);
    return user;
  }

  Future<LangpalUser?> getUserByID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final users = firestoreInstance.collection("users");
    final userRef = users.doc(userID);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      print("The user exists");
      final data = userSnapshot.data()!;
      final user = LangpalUser.fromMap(data);
      return user;
    } else {
      print("The user doesn't exist");
      return null;
    }
  }
}
