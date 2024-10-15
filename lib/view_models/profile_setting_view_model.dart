import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/langpal_user_info.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/fields/first_language_dropdown_provider.dart';
import 'package:langpal/providers/fields/level_dropdown_provider.dart';
import 'package:langpal/providers/fields/target_language_dropdown_provider.dart';
import 'package:langpal/providers/fields/username_text_field_provider.dart';
import 'package:langpal/providers/temp_user_provider.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setting_view_model.g.dart';

@riverpod
class ProfileSettingViewModel extends _$ProfileSettingViewModel {
  late final UserRepository userRepository;
  Future<void> addToFirestoreAndUpdateUser() async {
    final firstLanguage = ref.read(firstLanguageDropdownProvider);
    final targetLanguage = ref.read(targetLanguageDropdownProvider);
    final level = ref.read(levelDropdownProvider);
    final username = ref.read(usernameTextFieldProvider);
    final displayName = ref.read(tempUserProvider)!["displayName"];
    final emailAddress = ref.read(tempUserProvider)!["emailAddress"];
    final userID = ref.read(tempUserProvider)!["userID"]!;
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
    await ref.read(currentUserProvider.notifier).setCurrentUser(user);
    await userRepository.addUser(user);
  }

  @override
  Future<void> build() async {
    userRepository = UserRepository();
  }
}
