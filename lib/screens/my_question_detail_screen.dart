import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/router.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/my_question_detail_view_model.dart';

class MyQuestionDetailScreen extends ConsumerStatefulWidget {
  final String questionID;
  const MyQuestionDetailScreen({
    super.key,
    required this.questionID,
  });
  @override
  ConsumerState<MyQuestionDetailScreen> createState() =>
      _MyQuestionDetailScreenState();
}

class _MyQuestionDetailScreenState extends ConsumerState<MyQuestionDetailScreen>
    with RouteAwareMixin {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(myQuestionDetailViewModelProvider);
    return asyncData.when(
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      loading: () {
        return const LoadingScreen();
      },
      data: (data) {
        if (data != null) {
          final question = data["question"] as Question;
          final answers = data["answers"] as List<Answer>;
          final answerOwnerProfilePhotos =
              data["answerOwnerProfilePhotos"] as List<Uint8List?>;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
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
                  context.go("/main/my_page/my_questions");
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(5, 5),
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  question.content,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  question.questionType.toKoreanName(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                onTapEditButton(widget.questionID);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                onTapDeleteButton(widget.questionID);
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
                    const SizedBox(height: 20),
                    Text(
                      "답변",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    if (answers.isEmpty)
                      const Text(
                        "등록된 답변이 없습니다",
                        textAlign: TextAlign.center,
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (question.chosenAnswerID == null)
                                  IconButton(
                                    onPressed: () {
                                      onCheckboxChecked(
                                        answerID: answers[index].id,
                                        context: context,
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.check_box_outline_blank),
                                  ),
                                if (question.chosenAnswerID ==
                                    answers[index].id)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          if (answerOwnerProfilePhotos[index] ==
                                              null)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(
                                                "assets/images/profile.png",
                                                width: 70,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      Icons.person);
                                                },
                                              ),
                                            )
                                          else
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: MemoryImage(
                                                answerOwnerProfilePhotos[
                                                    index]!,
                                              ),
                                            ),
                                          const SizedBox(width: 10),
                                          Text(
                                            answers[index].ownerUsername,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(5, 5),
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          answers[index].content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: answers.length,
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }

  @override
  void didPopNext() {
    ref
        .read(myQuestionDetailViewModelProvider.notifier)
        .fetchMyQuestionDetail(widget.questionID);
    super.didPopNext();
  }

  @override
  void didPush() {
    ref
        .read(myQuestionDetailViewModelProvider.notifier)
        .fetchMyQuestionDetail(widget.questionID);
    super.didPush();
  }

  @override
  void initState() {
    ref
        .read(myQuestionDetailViewModelProvider.notifier)
        .fetchMyQuestionDetail(widget.questionID);
    super.initState();
  }

  void onCheckboxChecked(
      {required String answerID, required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("이 답변을 선택하시겠어요?"),
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(myQuestionDetailViewModelProvider.notifier)
                    .setChosenAnswer(
                        questionID: widget.questionID, answerID: answerID);
                await ref
                    .read(myQuestionDetailViewModelProvider.notifier)
                    .addNotification(answerID);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "선택",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "취소",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  void onTapDeleteButton(String questionID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말 질문을 삭제하시겠어요?"),
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(myQuestionDetailViewModelProvider.notifier)
                    .deleteQuestionByID(questionID);
                context.go("/main/my_page/my_questions");
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("질문이 성공적으로 삭제되었습니다"),
                  ),
                );
              },
              child: const Text(
                "삭제",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("취소"),
            )
          ],
        );
      },
    );
  }

  void onTapEditButton(String questionID) {
    context.go("/main/my_page/my_questions/detail/$questionID/edit");
  }
}
