import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/question_card.dart';
import 'package:langpal/providers/questions_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncQuestions = ref.watch(questionsProvider);
    return asyncQuestions.when(
      loading: () {
        return const LoadingScreen();
      },
      error: (error, stackTrace) {
        return ErrorScreen(message: error.toString());
      },
      data: (questions) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "답변하기",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                onPressed: () {
                  context.go("/main/notifications");
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                context.go("/main/my_page");
              },
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) => QuestionCard(
              question: questions[index],
              route: "/main/questions/${questions[index].id}",
            ),
            itemCount: questions!.length,
          ),
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go("/main/new_question");
            },
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
