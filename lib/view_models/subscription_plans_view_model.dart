import 'package:langpal/providers/current_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_plans_view_model.g.dart';

@riverpod
class SubscriptionPlansViewModel extends _$SubscriptionPlansViewModel {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  Future<void> promoteCurrentUser() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final modifiedCurrentUser = currentUser.copyWith(isPremium: true);
    await ref
        .read(currentUserProvider.notifier)
        .setCurrentUser(modifiedCurrentUser);
  }
}
