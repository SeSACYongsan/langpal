import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/langpal_user_info.dart';
import 'package:langpal/models/sign_in_status.dart';
import 'package:langpal/providers/fields/first_language_dropdown_provider.dart';
import 'package:langpal/providers/fields/level_dropdown_provider.dart';
import 'package:langpal/providers/fields/target_language_dropdown_provider.dart';
import 'package:langpal/providers/fields/username_text_field_provider.dart';
import 'package:langpal/providers/temp_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  void addToFirestoreAndUpdateUser() async {
    final firstLanguage = ref.read(firstLanguageDropdownProvider);
    final targetLanguage = ref.read(targetLanguageDropdownProvider);
    final level = ref.read(levelDropdownProvider);
    final username = ref.read(usernameTextFieldProvider);
    final firestoreInstance = FirebaseFirestore.instance;
    final users = firestoreInstance.collection("users");
    final displayName = ref.read(tempUserProvider)!["displayName"];
    final emailAddress = ref.read(tempUserProvider)!["emailAddress"];
    final userID = ref.read(tempUserProvider)!["userID"]!;
    final userReference = users.doc(userID);
    final info = LangpalUserInfo(
      firstLanguage: firstLanguage,
      targetLanguage: targetLanguage,
      level: level,
      username: username,
    );
    final user = LangpalUser(
      id: userID,
      displayName: displayName!,
      emailAddress: emailAddress!,
      info: info,
      isPremium: false,
      point: 0,
    );
    state = AsyncData(user);
    await userReference.set(user.toJson());
  }

  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<void> fetchUserByID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final userReference = firestoreInstance.collection("users").doc(userID);
    final userSnapshot = await userReference.get();
    try {
      if (userSnapshot.exists) {
        final user = userSnapshot.data();
        if (user != null) {
          final langpalUser = LangpalUser.fromJson(user);
          state = AsyncData(langpalUser);
        } else {
          throw Exception("The user is null");
        }
      } else {
        throw Exception("The user doesn't exist");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<SignInStatus> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    try {
      if (account != null) {
        final authentication = await account.authentication;
        final googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        final credential =
            await FirebaseAuth.instance.signInWithCredential(googleCredential);
        if (credential.user != null) {
          final userID = credential.user!.uid;
          final firestoreInstance = FirebaseFirestore.instance;
          final users = firestoreInstance.collection("users");
          final userReference = users.doc(userID);
          final snapshot = await userReference.get();
          if (snapshot.exists) {
            if (snapshot.data() != null) {
              final user = LangpalUser.fromJson(snapshot.data()!);
              state = AsyncData(user);
              return SignInStatus.userExist;
            } else {
              throw Exception("The snapshot data doesn't exist");
            }
          } else {
            final displayName = credential.user!.displayName!;
            final emailAddress = credential.user!.email!;
            final userID = credential.user!.uid;
            ref.read(tempUserProvider.notifier).setTempUser({
              "displayName": displayName,
              "emailAddress": emailAddress,
              "userID": userID,
            });
            return SignInStatus.userNotExist;
          }
        } else {
          throw Exception("The credential user is null");
        }
      } else {
        throw Exception("The account is null");
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
    return SignInStatus.signInFailed;
  }
}
