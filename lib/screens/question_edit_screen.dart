import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/question_edit_view_model.dart';

class QuestionEditScreen extends ConsumerStatefulWidget {
  final String questionID;
  const QuestionEditScreen({
    super.key,
    required this.questionID,
  });
  @override
  ConsumerState<QuestionEditScreen> createState() => _QuestionEditScreenState();
}

class _QuestionEditScreenState extends ConsumerState<QuestionEditScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(questionEditViewModelProvider);
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
                "질문 수정하기",
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
                  clearFields();
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
                              .read(questionEditViewModelProvider.notifier)
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
                                .read(questionEditViewModelProvider.notifier)
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
                              thumbColor: Colors.blue,
                              activeColor: Colors.blue,
                              onChanged: (newValue) {
                                ref
                                    .read(
                                        questionEditViewModelProvider.notifier)
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
                          "수정",
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

  void clearFields() async {
    await ref.read(questionEditViewModelProvider.notifier).resetFields();
  }

  @override
  void initState() {
    ref
        .read(questionEditViewModelProvider.notifier)
        .fetchQuestionDetailByID(widget.questionID);
    super.initState();
  }

  Future<void> onTapSubmitButton() async {
    final content =
        ref.read(questionEditViewModelProvider).value!["content"] as String;
    if (content.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("내용을 입력해주세요"),
            icon: Icon(Icons.info),
          );
        },
      );
    } else {
      await ref
          .read(questionEditViewModelProvider.notifier)
          .submitQuestionByQuestionID(widget.questionID);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("질문이 성공적으로 수정되었습니다"),
        ),
      );
      clearFields();
      Navigator.of(context).pop();
    }
  }
}
