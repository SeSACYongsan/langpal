import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temp_user_provider.g.dart';

@Riverpod(keepAlive: true)
class TempUser extends _$TempUser {
  @override
  Map<String, String>? build() {
    return null;
  }

  void setTempUser(Map<String, String> data) {
    state = data;
  }
}
