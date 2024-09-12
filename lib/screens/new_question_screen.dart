import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/new_question_provider.dart';
import 'package:langpal/providers/point_slider_provider.dart';
import 'package:langpal/providers/question_type_provider.dart';

class NewQuestionScreen extends ConsumerStatefulWidget {
  const NewQuestionScreen({super.key});
  @override
  ConsumerState<NewQuestionScreen> createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends ConsumerState<NewQuestionScreen> {
  final questionTypeTextEditingController = TextEditingController();
  final newQuestionTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    questionTypeTextEditingController.text =
        ref.watch(questionTypeProvider).toKoreanName();
    newQuestionTextEditingController.text = ref.watch(newQuestionProvider);
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
                DropdownMenu(
                  onSelected: (value) {
                    ref
                        .read(questionTypeProvider.notifier)
                        .setQuestionType(value!);
                  },
                  expandedInsets: EdgeInsets.zero,
                  controller: questionTypeTextEditingController,
                  dropdownMenuEntries: QuestionType.values.map((questionType) {
                    return DropdownMenuEntry(
                        value: questionType,
                        label: questionType.toKoreanName());
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
                      ref.read(newQuestionProvider.notifier).setString(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
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
                  onPressed: () {},
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

  @override
  void dispose() {
    questionTypeTextEditingController.dispose();
    newQuestionTextEditingController.dispose();
    super.dispose();
  }
}
