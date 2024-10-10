import 'dart:async';

import 'package:langpal/models/answer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'answers_provider.g.dart';

@riverpod
class Answers extends _$Answers {
  @override
  Future<List<Answer>> build() async {
    return [];
  }
}
