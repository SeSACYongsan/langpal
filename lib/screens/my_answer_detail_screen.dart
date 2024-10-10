import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/my_answer_detail_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';

class MyAnswerDetailScreen extends ConsumerWidget {
  final String answerID;
  const MyAnswerDetailScreen({
    super.key,
    required this.answerID,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(myAnswerDetailProvider(answerID));
    return asyncData.when(
      error: (error, stackTrace) {
        return ErrorScreen(message: error.toString());
      },
      loading: () {
        return const LoadingScreen();
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final answer = data["answer"] as Answer;
          final question = data["question"] as Question;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "나의 답변",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.go("/main/my_page/my_answers");
                },
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.blue),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                            color: Colors.black12,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question.content,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            question.questionType.toKoreanName(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "나의 답변",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(5, 5),
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Text(
                        answer.content,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                      onPressed: () {},
                      child: const Text("수정하기"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
