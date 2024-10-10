import 'package:langpal/providers/answers_provider.dart';
import 'package:langpal/providers/question_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_question_detail_provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> myQuestionDetail(
    MyQuestionDetailRef ref, String questionID) async {
  await Future.wait([
    ref.read(questionProvider.notifier).fetchQuestionByID(questionID),
    ref.read(answersProvider.notifier).fetchAnswersByQuestionID(questionID)
  ]);
  final question = ref.watch(questionProvider).value;
  final answers = ref.watch(answersProvider).value;
  if (question == null || answers == null) {
    print("Question: $question, answers: $answers");
  }
  return {
    "question": question,
    "answers": answers,
  };
}
