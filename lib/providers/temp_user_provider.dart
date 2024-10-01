import 'package:flutter_riverpod/flutter_riverpod.dart';

final tempUserProvider =
    NotifierProvider<TempUserNotifier, Map<String, String>?>(() {
  return TempUserNotifier();
});

class TempUserNotifier extends Notifier<Map<String, String>?> {
  @override
  Map<String, String>? build() {
    return null;
  }

  void setTempUser(Map<String, String> data) {
    state = data;
  }
}
