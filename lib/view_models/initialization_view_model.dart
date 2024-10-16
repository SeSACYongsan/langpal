import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initialization_view_model.g.dart';

@Riverpod(keepAlive: true)
class InitializationViewModel extends _$InitializationViewModel {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  void resetState() {
    updateState(
      firstLanguage: Language.korean,
      targetLanguage: Language.english,
      level: Level.beginner,
    );
  }

  void setFirstLanguage(Language firstLanguage) {
    updateState(firstLanguage: firstLanguage);
  }

  void setLevel(Level level) {
    updateState(level: level);
  }

  void setTargetLanguage(Language targetLanguage) {
    updateState(targetLanguage: targetLanguage);
  }

  void updateState({
    Language? firstLanguage,
    Language? targetLanguage,
    Level? level,
  }) {
    state = AsyncData({
      "firstLanguage":
          firstLanguage ?? state.value!["firstLanguage"] as Language,
      "targetLanguage":
          targetLanguage ?? state.value!["targetLanguage"] as Language,
      "level": level ?? state.value!["Level"] as Level,
    });
  }
}
