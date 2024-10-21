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
            body: questions.isEmpty
                ? Center(
                    child: Text(
                      "질문이 없어요",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: QuestionCard(
                                question: questions[index],
                                route:
                                    "/main/my_page/my_questions/detail/${questions[index].id}",
                                profilePhoto: null,
                                isProfileVisible: false,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    onTapDeleteButton(questions[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          ],
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

  void onTapDeleteButton(String questionID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말 삭제하시겠어요?"),
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(myQuestionsViewModelProvider.notifier)
                    .deleteQuestionByID(questionID);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("질문이 성공적으로 삭제되었습니다"),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                "삭제",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("취소"),
            ),
          ],
        );
      },
    );
  }
}
