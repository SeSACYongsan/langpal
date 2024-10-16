import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initialization_view_model.g.dart';

@riverpod
class InitializationViewModel extends _$InitializationViewModel {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  Future<void> resetFields() async {
    state = const AsyncData({
      "firstLanguage": Language.korean,
      "targetLanguage": Language.english,
      "level": Level.beginner,
    });
  }

  Future<void> setFirstLanguage(Language firstLanguage) async {
    state = AsyncData({
      "firstLanguage": firstLanguage,
      "targetLanguage": state.value!["targetLanguage"] as Language,
      "level": state.value!["level"] as Level,
    });
  }

  Future<void> setLevel(Level level) async {
    state = AsyncData({
      "firstLanguage": state.value!["firstLanguage"] as Language,
      "targetLanguage": state.value!["targetLanguage"] as Language,
      "level": level,
    });
  }

  Future<void> setTargetLanguage(Language targetLanguage) async {
    state = AsyncData({
      "firstLanguage": state.value!["firstLanguage"] as Language,
      "targetLanguage": targetLanguage,
      "level": state.value!["level"] as Level,
    });
  }
}
