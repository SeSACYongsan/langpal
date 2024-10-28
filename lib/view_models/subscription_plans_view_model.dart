import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_plans_view_model.g.dart';

@riverpod
class SubscriptionPlansViewModel extends _$SubscriptionPlansViewModel {
  late final UserRepository userRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    userRepository = UserRepository();
    return null;
  }

  Future<void> promoteCurrentUser() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final modifiedCurrentUser = currentUser.copyWith(isPremium: true);
    await userRepository.updateUser(modifiedCurrentUser);
    await ref
        .read(currentUserProvider.notifier)
        .setCurrentUser(modifiedCurrentUser);
  }
}
