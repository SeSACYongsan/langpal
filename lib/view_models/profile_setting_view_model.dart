import 'package:image_picker/image_picker.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/langpal_user_info.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/providers/temp_user_provider.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:langpal/utils/logger.dart';
import 'package:langpal/view_models/initialization_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_setting_view_model.g.dart';

@riverpod
class ProfileSettingViewModel extends _$ProfileSettingViewModel {
  late final UserRepository userRepository;
  Future<void> addToFirestoreAndUpdateUser() async {
    final firstLanguage = ref
        .read(initializationViewModelProvider)
        .value!["firstLanguage"] as Language;
    final targetLanguage = ref
        .read(initializationViewModelProvider)
        .value!["targetLanguage"] as Language;
    final level =
        ref.read(initializationViewModelProvider).value!["level"] as Level;
    final username = state.value!["username"] as String;
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
  Future<Map<String, dynamic>?> build() async {
    userRepository = UserRepository();
    return null;
  }

  Future<void> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedImage != null) {
        state = AsyncData({
          "username": state.value!["username"] as String,
          "profileImage": pickedImage,
        });
      } else {
        throw Exception("The picked image is null");
      }
    } catch (error) {
      logger.e(error);
    }
  }

  void resetState() {
    state = const AsyncData({
      "username": "",
      "profileImage": null,
    });
  }

  void setUsername(String username) {
    state = AsyncData({
      "username": username,
      "profileImage": state.value!["profileImage"] as XFile?
    });
  }
}
