import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/fields/new_question_text_field_provider.dart';
import 'package:langpal/providers/fields/point_slider_provider.dart';
import 'package:langpal/providers/fields/question_type_dropdown_provider.dart';

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
  late TextEditingController questionTypeTextEditingController;
  late TextEditingController newQuestionTextEditingController;
  @override
  Widget build(BuildContext context) {
    newQuestionTextEditingController.text =
        ref.watch(newQuestionTextFieldProvider);
    questionTypeTextEditingController.text =
        ref.watch(questionTypeDropdownProvider).toKoreanName();
    final currentPoint = ref.watch(pointSliderProvider);
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
                  value: ref.watch(questionTypeDropdownProvider),
                  onChanged: (value) {
                    ref
                        .read(questionTypeDropdownProvider.notifier)
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
                  child: TextField(
                    controller: newQuestionTextEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "질문을 입력하세요",
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    onChanged: (value) {
                      ref
                          .read(newQuestionTextFieldProvider.notifier)
                          .setString(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  currentPoint.toStringAsFixed(0),
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
                        value: ref.watch(pointSliderProvider),
                        min: 0,
                        max: 100,
                        thumbColor: Colors.blue,
                        activeColor: Colors.blue,
                        onChanged: (newValue) {
                          ref
                              .read(pointSliderProvider.notifier)
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
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

  void clearFields() {
    ref.read(questionTypeDropdownProvider.notifier).initializeQuestionType();
    ref.read(newQuestionTextFieldProvider.notifier).initializeNewQuestion();
    ref.read(pointSliderProvider.notifier).initializePoint();
  }

  @override
  void initState() {
    questionTypeTextEditingController = TextEditingController();
    newQuestionTextEditingController = TextEditingController();
    super.initState();
  }

  Future<void> onTapSubmitButton() async {}
}
