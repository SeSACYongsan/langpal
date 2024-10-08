import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'target_language_dropdown_provider.g.dart';

@riverpod
class TargetLanguageDropdown extends _$TargetLanguageDropdown {
  @override
  Language build() {
    return Language.english;
  }

  void setLanguage(Language language) {
    state = language;
  }
}
