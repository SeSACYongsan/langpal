import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameProvider = StateNotifierProvider<UsernameNotifier, String>(
    (ref) => UsernameNotifier());

class UsernameNotifier extends StateNotifier<String> {
  UsernameNotifier() : super("");
  void setUsername(String string) {
    state = string;
  }
}
