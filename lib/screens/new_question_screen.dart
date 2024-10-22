import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/new_question_view_model.dart';

class NewQuestionScreen extends ConsumerStatefulWidget {
  const NewQuestionScreen({super.key});
  @override
  ConsumerState<NewQuestionScreen> createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends ConsumerState<NewQuestionScreen> {
  late TextEditingController questionTypeTextEditingController;
  late TextEditingController newQuestionTextEditingController;
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(newQuestionViewModelProvider);
    return asyncData.when(
      loading: () {
        return const LoadingScreen();
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final questionType = data["questionType"] as QuestionType;
          final content = data["content"] as String;
          final point = data["point"] as double;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                "질문하기",
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
                  ref.read(newQuestionViewModelProvider.notifier).resetState();
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButton2(
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                        ),
                        value: questionType,
                        onChanged: (value) {
                          ref
                              .read(newQuestionViewModelProvider.notifier)
                              .setQuestionType(value!);
                        },
                        isExpanded: true,
                        items: QuestionType.values.map((questionType) {
                          return DropdownMenuItem<QuestionType>(
                              value: questionType,
                              child: Text(questionType.toKoreanName()));
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          initialValue: content,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "질문을 입력하세요",
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          onChanged: (value) {
                            ref
                                .read(newQuestionViewModelProvider.notifier)
                                .setContent(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        point.toStringAsFixed(0),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            "0",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Expanded(
                            child: Slider(
                              value: point,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              thumbColor: Colors.blue,
                              activeColor: Colors.blue,
                              label: ref
                                  .read(newQuestionViewModelProvider)
                                  .value!["point"]
                                  .toStringAsFixed(0),
                              onChanged: (newValue) {
                                ref
                                    .read(newQuestionViewModelProvider.notifier)
                                    .setPoint(newValue);
                              },
                            ),
                          ),
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15),
                          elevation: 10,
                        ),
                        onPressed: () async {
                          await onTapSubmitButton();
                        },
                        child: Text(
                          "등록",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
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
    Future(
      () {
        ref.read(newQuestionViewModelProvider.notifier).resetState();
      },
    );
    super.initState();
  }

  Future<void> onTapSubmitButton() async {
    if (ref
        .read(newQuestionViewModelProvider)
        .value!["content"]
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
    } else if (ref.read(newQuestionViewModelProvider).value!["point"] >
        ref.read(currentUserProvider).value!.point) {
      final currentUserPoint = ref.read(currentUserProvider).value!.point;
      showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text("포인트가 부족합니다. (현재 포인트: $currentUserPoint)"),
          );
        },
      );
    } else {
      await ref.read(newQuestionViewModelProvider.notifier).addQuestion();
      final point = ref.read(newQuestionViewModelProvider).value!["point"];
      ref.read(newQuestionViewModelProvider.notifier).updatePoint(-point);
      ref.read(newQuestionViewModelProvider.notifier).resetState();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("질문이 성공적으로 등록되었습니다"),
        ),
      );
      context.go("/main");
    }
  }
}
