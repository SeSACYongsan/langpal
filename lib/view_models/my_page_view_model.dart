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

  void fetchCurrentUser() async {
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
