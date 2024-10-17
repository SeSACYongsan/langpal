import "dart:io";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/utils/logger.dart';

class UserRepository {
  Future<void> addUser(LangpalUser user) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("users").doc(user.id).set(user.toJson());
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
    required XFile? profilePhoto,
    required String userID,
  }) async {
    final storageInstance = FirebaseStorage.instance;
    final file = File(profilePhoto!.path);
    await storageInstance.ref("profilePhotos/$userID").putFile(file);
  }
}
