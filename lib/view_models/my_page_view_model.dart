import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_page_view_model.g.dart';

@riverpod
class MyPageViewModel extends _$MyPageViewModel {
  @override
  Future<LangpalUser?> build() async {
    return null;
  }

  Future<void> fetchCurrentUser() async {
    final currentUser = ref.read(currentUserProvider).value!;
    state = AsyncData(currentUser);
  }
}