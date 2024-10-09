import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temp_user_provider.g.dart';

@riverpod
class TempUser extends _$TempUser {
  @override
  Map<String, String>? build() {
    return null;
  }

  void setTempUser(Map<String, String> data) {
    state = data;
  }
}
