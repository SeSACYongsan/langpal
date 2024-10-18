import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/utils/logger.dart';

class UserRepository {
  Future<void> addUser(LangpalUser user) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("users").doc(user.id).set(user.toJson());
  }

  Future<Uint8List?> fetchProfilePhotoByUserID(String userID) async {
    final storageInstance = FirebaseStorage.instance;
    try {
      final data = await storageInstance.ref("profilePhotos/$userID").getData();
      return data;
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<LangpalUser?> fetchUserByID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final userSnapshot =
        await firestoreInstance.collection("users").doc(userID).get();
    try {
      if (userSnapshot.exists) {
        final user = LangpalUser.fromJson(userSnapshot.data()!);
        return user;
      } else {
        throw Exception("The user doesn't exist");
      }
    } catch (error) {
      logger.e(error);
    }
    return null;
  }

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
      logger.e(error);
    }
    return null;
  }

  Future<void> uploadProfilePhoto({
    required Uint8List? profilePhoto,
    required String userID,
  }) async {
    final storageInstance = FirebaseStorage.instance;
    await storageInstance.ref("profilePhotos/$userID").putData(profilePhoto!);
  }
}
