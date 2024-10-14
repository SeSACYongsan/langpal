import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/fields/new_answer_text_field_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/my_answer_detail_view_model.dart';

class MyAnswerDetailScreen extends ConsumerStatefulWidget {
  final String answerID;
  const MyAnswerDetailScreen({
    super.key,
    required this.answerID,
  });
  @override
  ConsumerState<MyAnswerDetailScreen> createState() =>
      _MyAnswerDetailScreenState();
}

class _MyAnswerDetailScreenState extends ConsumerState<MyAnswerDetailScreen> {
  late TextEditingController newAnswerTextEditingController;
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(myAnswerDetailViewModelProvider);
    newAnswerTextEditingController.text = ref.watch(newAnswerTextFieldProvider);
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
          final isEditable = data["isEditable"] as bool;
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
                    if (!isEditable)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            onPressed: onTapEditButton,
                            child: const Text("수정하기"),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              controller: newAnswerTextEditingController,
                              maxLines: 3,
                              onChanged: (value) {
                                ref
                                    .read(newAnswerTextFieldProvider.notifier)
                                    .setNewAnswer(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(15),
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                            onPressed: onTapSubmitButton,
                            child: const Text("수정하기"),
                          ),
                        ],
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
  void dispose() {
    newAnswerTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ref
        .read(myAnswerDetailViewModelProvider.notifier)
        .fetchMyAnswerDetail(widget.answerID);
    newAnswerTextEditingController = TextEditingController();
    super.initState();
  }

  void onTapEditButton() async {
    await ref
        .read(myAnswerDetailViewModelProvider.notifier)
        .setIsEditable(true);
  }

  void onTapSubmitButton() async {
    await ref
        .read(myAnswerDetailViewModelProvider.notifier)
        .updateAnswerByAnswerID(widget.answerID);
    await ref
        .read(myAnswerDetailViewModelProvider.notifier)
        .setIsEditable(false);
  }
}
