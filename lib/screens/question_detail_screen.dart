import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:langpal/providers/answers_provider.dart';
import 'package:langpal/providers/current_user_id_provider.dart';
import 'package:langpal/providers/fields/answer_text_field_provider.dart';
import 'package:langpal/providers/question_provider.dart';
import 'package:langpal/providers/user_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:uuid/uuid.dart';

class QuestionDetailScreen extends ConsumerStatefulWidget {
  final String questionID;
  const QuestionDetailScreen({super.key, required this.questionID});
  @override
  ConsumerState<QuestionDetailScreen> createState() =>
      _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends ConsumerState<QuestionDetailScreen> {
  late TextEditingController answerTextEditingController;
  @override
  Widget build(BuildContext context) {
    final asyncQuestion = ref.watch(questionProvider(widget.questionID));
    answerTextEditingController.text = ref.watch(answerTextFieldProvider);
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
      body: asyncQuestion.when(
        data: (question) {
          final ownerID = question!.ownerID;
          final asyncUser = ref.watch(userProvider(ownerID));
          return asyncUser.when(
            data: (user) {
              final questionID = question.id;
              final asyncAnswers = ref.watch(answersProvider(questionID));
              return asyncAnswers.when(
                data: (answers) {
                  return SingleChildScrollView(
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
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user!.info.username,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    "${user.info.targetLanguage.toKoreanName()} 수준: ${user.info.level.toKoreanName()}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ...answers!.map((answer) {
                            return Text(answer.content);
                          }),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/profile.png",
                              width: 70,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: answerTextEditingController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "답변을 입력하세요",
                                ),
                                maxLines: 8,
                                onChanged: (value) {
                                  ref
                                      .read(answerTextFieldProvider.notifier)
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
                              onPressed: () {
                                if (answerTextEditingController.text
                                    .trim()
                                    .isEmpty) {
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
                                  submitAnswer();
                                }
                              },
                              child: Text(
                                "답변하기",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  print(error);
                  return const ErrorScreen();
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              );
            },
            error: (error, stackTrace) {
              print(error);
              return const ErrorScreen();
            },
            loading: () {
              return const CircularProgressIndicator();
            },
          );
        },
        error: (error, stackTrace) {
          print(error);
          return const ErrorScreen();
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    answerTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    answerTextEditingController = TextEditingController();
    super.initState();
  }

  Future<void> registerAnswer(Answer answer) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final answerReference =
        firestoreInstance.collection("answers").doc(answer.id);
    await answerReference.set(answer.toMap());
  }

  Future<void> submitAnswer() async {
    const uuid = Uuid();
    final content = answerTextEditingController.text;
    final ownerID = ref.read(currentUserIDProvider)!;
    final id = uuid.v4();
    final questionID = widget.questionID;
    final newAnswer = Answer(
        id: id, ownerID: ownerID, questionID: questionID, content: content);
    registerAnswer(newAnswer);
  }
}
