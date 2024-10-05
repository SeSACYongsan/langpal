import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';

final firstLanguageDropdownProvider =
    NotifierProvider<FirstLanguageDropdownNotifier, Language>(
        () => FirstLanguageDropdownNotifier());

class FirstLanguageDropdownNotifier extends Notifier<Language> {
  @override
  Language build() {
    return Language.korean;
  }

  void setLanguage(Language language) {
    state = language;
  }
}
