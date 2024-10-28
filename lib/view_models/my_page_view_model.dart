import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_page_view_model.g.dart';

@riverpod
class MyPageViewModel extends _$MyPageViewModel {
  late final UserRepository userRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    userRepository = UserRepository();
    return null;
  }

  Future<void> demoteCurrentUser() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final modifiedCurrentUser = currentUser.copyWith(isPremium: false);
    await userRepository.updateUser(modifiedCurrentUser);
    await ref
        .read(currentUserProvider.notifier)
        .setCurrentUser(modifiedCurrentUser);
    state = AsyncData({
      "currentUser": modifiedCurrentUser,
      "profilePhoto": state.value!["profilePhoto"] as Uint8List?,
    });
  }

  Future<void> fetchCurrentUser() async {
    final currentUser = ref.read(currentUserProvider).value;
    final profilePhoto =
        await userRepository.fetchProfilePhotoByUserID(currentUser!.id);
    state = AsyncData({
      "currentUser": currentUser,
      "profilePhoto": profilePhoto,
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await ref.read(currentUserProvider.notifier).reset();
  }
}
