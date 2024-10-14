import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/answer_card.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/my_answers_view_model.dart';

class MyAnswersScreen extends ConsumerStatefulWidget {
  const MyAnswersScreen({super.key});
  @override
  ConsumerState<MyAnswersScreen> createState() => _MyAnswersScreenState();
}

class _MyAnswersScreenState extends ConsumerState<MyAnswersScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(myAnswersViewModelProvider);
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
          final answers = data["answers"] as List<Answer>;
          final answerOwners = data["answerOwners"] as List<LangpalUser?>;
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
                  context.go("/main/my_page");
                },
              ),
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.go(
                            "/main/my_page/my_answers/detail/${answers[index].id}");
                      },
                      child: AnswerCard(
                        answer: answers[index],
                        owner: answerOwners[index]!,
                        isProfileVisible: false,
                      ),
                    );
                  },
                  itemCount: answers.length,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    ref.read(myAnswersViewModelProvider.notifier).fetchMyAnswers();
    super.initState();
  }
}
