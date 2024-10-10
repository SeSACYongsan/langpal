import 'package:langpal/providers/answer_provider.dart';
import 'package:langpal/providers/question_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answer_detail_provider.g.dart';

@riverpod
Future<Map<String, dynamic>?> myAnswerDetail(
    MyAnswerDetailRef ref, String answerID) async {
  await Future.wait([
    ref.read(answerProvider.notifier).fetchAnswerByID(answerID),
    ref.read(questionProvider.notifier).fetchQuestionByAnswerID(answerID)
  ]);
  final answer = ref.watch(answerProvider).value;
  final question = ref.watch(questionProvider).value;
  if (answer == null || question == null) {
    print("Answer: $answer, question: $question");
  }
  return {
    "answer": answer,
    "question": question,
  };
}
