import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/langpal_user_info.dart';
import 'package:langpal/models/sign_in_status.dart';
import 'package:langpal/providers/first_language_provider.dart';
import 'package:langpal/providers/level_provider.dart';
import 'package:langpal/providers/target_language_provider.dart';
import 'package:langpal/providers/temp_user_provider.dart';
import 'package:langpal/providers/username_provider.dart';

final currentUserProvider = NotifierProvider<CurrentUserNotifier, String?>(
  () {
    return CurrentUserNotifier();
  },
);

class CurrentUserNotifier extends Notifier<String?> {
  void addToFirestore() async {
    final firstLanguage = ref.read(firstLanguageProvider);
    final targetLanguage = ref.read(targetLanguageProvider);
    final level = ref.read(levelProvider);
    final username = ref.read(usernameProvider);
    final firestoreInstance = FirebaseFirestore.instance;
    final users = firestoreInstance.collection("users");
    final displayName = ref.read(tempUserProvider)!["displayName"];
    final emailAddress = ref.read(tempUserProvider)!["emailAddress"];
    final userID = ref.read(tempUserProvider)!["userID"];
    final userRef = users.doc(userID);
    state = userID;
    final info = LangpalUserInfo(
      firstLanguage: firstLanguage,
      targetLanguage: targetLanguage,
      level: level,
      username: username,
    );
    final user = LangpalUser(
      displayName: displayName!,
      userID: userID!,
      emailAddress: emailAddress!,
      info: info,
    );
    await userRef.set(user.toMap());
  }

  @override
  build() {
    return null;
  }

  Future<SignInStatus> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
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
        final userRef = users.doc(userID);
        final snapshot = await userRef.get();
        if (snapshot.exists) {
          if (snapshot.data() != null) {
            print("The snapshot data exists");
            state = userID;
            return SignInStatus.userExist;
          } else {
            print("The snapshot data doesn't exist");
            return SignInStatus.signInFailed;
          }
        } else {
          print("The snapshot doesn't exist");
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
        print("The credential user is null");
        return SignInStatus.signInFailed;
      }
    } else {
      print("The account is null");
      return SignInStatus.signInFailed;
    }
  }
}
