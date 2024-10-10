import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/components/question_card.dart';
import 'package:langpal/providers/my_questions_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';

class MyQuestionsScreen extends ConsumerStatefulWidget {
  const MyQuestionsScreen({super.key});
  @override
  ConsumerState<MyQuestionsScreen> createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends ConsumerState<MyQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncQuestions = ref.watch(myQuestionsProvider);
    return asyncQuestions.when(
      error: (error, stackTrace) {
        return ErrorScreen(message: error.toString());
      },
      loading: () {
        return const LoadingScreen();
      },
      data: (questions) {
        if (questions == null) {
          return const LoadingScreen();
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "나의 질문",
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
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: QuestionCard(
                    question: questions[index],
                    route:
                        "/main/my_page/my_questions/detail/${questions[index].id}",
                  ),
                );
              },
              itemCount: questions.length,
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    ref.refresh(myQuestionsProvider);
    super.initState();
  }
}
