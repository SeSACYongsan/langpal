import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/answer_card.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/providers/my_answers_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';

class MyAnswersScreen extends ConsumerWidget {
  const MyAnswersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAnswers = ref.watch(myAnswersProvider);
    return asyncAnswers.when(
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
          final user = data["user"] as LangpalUser;
          final answers = data["answers"] as List<Answer>;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "나의 답변",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...answers.map(
                      (answer) {
                        return GestureDetector(
                          onTap: () {
                            context.go(
                                "/main/my_page/my_answers/detail/${answer.id}");
                          },
                          child: AnswerCard(
                            answer: answer,
                            user: user,
                          ),
                        );
                      },
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
