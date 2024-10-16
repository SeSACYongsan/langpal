import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/sign_in_status.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/temp_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  @override
  Future<void> build() async {
    ref.listen(currentUserProvider, (previous, next) {
      if (next is AsyncData) {}
    });
  }

  SignInStatus signInWithApple() {
    return SignInStatus.signInFailed;
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
          final userSnapshot =
              await firestoreInstance.collection("users").doc(userID).get();
          if (userSnapshot.exists) {
            if (userSnapshot.data() != null) {
              final user = LangpalUser.fromJson(userSnapshot.data()!);
              await ref.read(currentUserProvider.notifier).setCurrentUser(user);
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
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
    return SignInStatus.signInFailed;
  }
}
