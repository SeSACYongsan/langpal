import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/answer_card.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/question_detail_view_model.dart';

class QuestionDetailScreen extends ConsumerStatefulWidget {
  final String questionID;
  const QuestionDetailScreen({super.key, required this.questionID});
  @override
  ConsumerState<QuestionDetailScreen> createState() =>
      _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends ConsumerState<QuestionDetailScreen> {
  late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(questionDetailViewModelProvider);
    final currentUser = ref.read(currentUserProvider).value!;
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
          final question = data["question"] as Question;
          final questionOwner = data["questionOwner"] as LangpalUser;
          final answers = data["answers"] as List<Answer>;
          final answerOwners = data["answerOwners"] as List<LangpalUser?>;
          final answer = data["answer"] as String;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                "답변하기",
                style: TextStyle(color: Colors.white),
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
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/profile.png",
                            width: 70,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              questionOwner.info.username,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "${questionOwner.info.targetLanguage.toKoreanName()} 수준: ${questionOwner.info.level.toKoreanName()}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${question.point.toStringAsFixed(0)} pt",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (questionOwner.id == currentUser.id)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  onTapEditButton(question.id);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  onTapDeleteButton(
                                      context: context,
                                      questionID: question.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                        question.content,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnswerCard(
                          answer: answers[index],
                          owner: answerOwners[index]!,
                          isProfileVisible: true,
                        );
                      },
                      itemCount: answers.length,
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/profile.png",
                        width: 70,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: Offset(5, 5),
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "답변을 입력하세요",
                          ),
                          maxLines: 8,
                          onChanged: (value) {
                            ref
                                .read(questionDetailViewModelProvider.notifier)
                                .setAnswer(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await onTapSubmitButton(question.id);
                        },
                        child: Text(
                          "답변하기",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
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

  @override
  void didUpdateWidget(covariant QuestionDetailScreen oldWidget) {
    ref
        .read(questionDetailViewModelProvider.notifier)
        .fetchQuestionDetail(widget.questionID);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    ref
        .read(questionDetailViewModelProvider.notifier)
        .fetchQuestionDetail(widget.questionID);
    textEditingController = TextEditingController();
    super.initState();
  }

  void onTapDeleteButton({
    required BuildContext context,
    required String questionID,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말 삭제하시겠어요?"),
          icon: const Icon(Icons.info),
          actions: [
            TextButton(
              onPressed: () {
                ref
                    .read(questionDetailViewModelProvider.notifier)
                    .deleteQuestionByID(questionID);
                if (context.mounted) {
                  context.go("/main");
                }
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("질문이 성공적으로 삭제되었습니다"),
                  ),
                );
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
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("취소"),
            ),
          ],
        );
      },
    );
  }

  void onTapEditButton(String questionID) {
    context.go("/main/questions/$questionID/edit");
  }

  Future<void> onTapSubmitButton(String questionID) async {
    final answer =
        ref.read(questionDetailViewModelProvider).value!["answer"] as String;
    if (answer.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("내용을 입력해주세요"),
            icon: Icon(Icons.error),
          );
        },
      );
    } else {
      await ref
          .read(questionDetailViewModelProvider.notifier)
          .addAnswer(widget.questionID);
      await ref
          .read(questionDetailViewModelProvider.notifier)
          .addNotificationByQuestionID(questionID);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("답변이 성공적으로 등록되었습니다"),
        ),
      );
      ref.read(questionDetailViewModelProvider.notifier).resetAnswer();
      textEditingController.text = "";
    }
  }
}
