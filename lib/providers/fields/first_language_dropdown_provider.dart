import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'first_language_dropdown_provider.g.dart';

@riverpod
class FirstLanguageDropdown extends _$FirstLanguageDropdown {
  @override
  Language build() {
    return Language.korean;
  }

  void setLanguage(Language language) {
    state = language;
  }
}
