import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/level.dart';

final levelDropdownProvider = NotifierProvider<LevelDropdownNotifier, Level>(
    () => LevelDropdownNotifier());

class LevelDropdownNotifier extends Notifier<Level> {
  @override
  Level build() {
    return Level.beginner;
  }

  void setLevel(Level level) {
    state = level;
  }
}
