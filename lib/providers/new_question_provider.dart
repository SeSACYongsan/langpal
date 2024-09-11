import 'package:flutter_riverpod/flutter_riverpod.dart';

final newQuestionProvider = StateNotifierProvider<NewQuestionNotifier, String>(
    (ref) => NewQuestionNotifier());

class NewQuestionNotifier extends StateNotifier<String> {
  NewQuestionNotifier() : super("");
  void setString(String string) {
    state = string;
  }
}
