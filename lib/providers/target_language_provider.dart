import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';

final targetLanguageProvider =
    StateNotifierProvider<TargetLanguageNotifier, Language>(
        (ref) => TargetLanguageNotifier());

class TargetLanguageNotifier extends StateNotifier<Language> {
  TargetLanguageNotifier() : super(Language.english);
  void setLanguage(Language language) {
    state = language;
  }
}
