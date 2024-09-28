import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langpal/models/langpal_user.dart';

final currentUserProvider = NotifierProvider<CurrentUserNotifier, LangpalUser?>(
  () {
    return CurrentUserNotifier();
  },
);

class CurrentUserNotifier extends Notifier<LangpalUser?> {
  @override
  build() {
    return null;
  }

  void setUser(LangpalUser user) {
    state = user;
  }

  Future<bool> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    if (account != null) {
      final authentication = await account.authentication;
      final googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final credential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      if (credential.user != null) {
        final displayName = credential.user!.displayName!;
        final emailAddress = credential.user!.email!;
        final userID = credential.user!.uid;
        final user = LangpalUser(
          userID: userID,
          displayName: displayName,
          emailAddress: emailAddress,
        );
        state = user;
        final firestoreInstance = FirebaseFirestore.instance;
        await firestoreInstance.collection("users").doc().set({
          userID: userID,
          displayName: displayName,
          emailAddress: emailAddress,
        });
        return true;
      }
    }
    return false;
  }
}
