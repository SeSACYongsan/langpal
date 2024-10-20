import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/question_card.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/my_questions_view_model.dart';

class MyQuestionsScreen extends ConsumerStatefulWidget {
  const MyQuestionsScreen({super.key});
  @override
  ConsumerState<MyQuestionsScreen> createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends ConsumerState<MyQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(myQuestionsViewModelProvider);
    return asyncData.when(
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      loading: () {
        return const LoadingScreen();
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final questions = data["questions"] as List<Question>;
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
                  context.go("/main/my_page");
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
                    profilePhoto: null,
                    isProfileVisible: false,
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
    ref.read(myQuestionsViewModelProvider.notifier).fetchMyQuestions();
    super.initState();
  }
}
