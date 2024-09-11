import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/level.dart';

final levelProvider =
    StateNotifierProvider<LevelNotifier, Level>((ref) => LevelNotifier());

class LevelNotifier extends StateNotifier<Level> {
  LevelNotifier() : super(Level.beginner);
  void setLevel(Level level) {
    state = level;
  }
}
