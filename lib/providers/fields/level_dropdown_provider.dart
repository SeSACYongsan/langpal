import 'package:langpal/models/level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'level_dropdown_provider.g.dart';

@riverpod
class LevelDropdown extends _$LevelDropdown {
  @override
  Level build() {
    return Level.beginner;
  }

  void setLevel(Level level) {
    state = level;
  }
}
