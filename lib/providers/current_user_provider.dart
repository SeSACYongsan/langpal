import 'package:langpal/models/langpal_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<void> setCurrentUser(LangpalUser user) async {
    state = AsyncData(user);
    print("Current user set: $state");
  }
}
