import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';

final targetLanguageDropdownProvider =
    NotifierProvider<TargetLanguageDropdownNotifier, Language>(
        () => TargetLanguageDropdownNotifier());

class TargetLanguageDropdownNotifier extends Notifier<Language> {
  @override
  Language build() {
    return Language.english;
  }

  void setLanguage(Language language) {
    state = language;
  }
}
