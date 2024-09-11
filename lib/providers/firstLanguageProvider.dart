import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';

final firstLanguageProvider =
    StateNotifierProvider<FirstLanguageNotifier, Language>(
        (ref) => FirstLanguageNotifier());

class FirstLanguageNotifier extends StateNotifier<Language> {
  FirstLanguageNotifier() : super(Language.korean);
  void setLanguage(Language language) {
    state = language;
  }
}
