import 'package:langpal/providers/answers_provider.dart';
import 'package:langpal/providers/question_provider.dart';
import 'package:langpal/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_detail_provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> questionDetail(
    QuestionDetailRef ref, String questionID) async {
  await Future.wait([
    ref.read(answersProvider.notifier).fetchAnswersByQuestionID(questionID),
    ref.read(questionProvider.notifier).fetchQuestionByID(questionID),
    ref.read(userProvider.notifier).fetchUserByQuestionID(questionID),
  ]);
  final answers = ref.watch(answersProvider).value!;
  final question = ref.watch(questionProvider).value!;
  final user = ref.watch(userProvider).value!;
  return {
    "answers": answers,
    "question": question,
    "user": user,
  };
}
