import 'package:langpal/providers/answers_provider.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answers_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> myAnswers(MyAnswersRef ref) async {
  await ref.read(answersProvider.notifier).fetchMyAnswers();
  final answers = ref.watch(answersProvider).value;
  final currentUser = ref.read(currentUserProvider).value;
  if (answers == null || currentUser == null) {
    print("Answers: $answers, user: $currentUser");
  }
  return {
    "answers": answers,
    "user": currentUser,
  };
}
