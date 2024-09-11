import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/question_type.dart';
import 'package:langpal/providers/point_slider_provider.dart';
import 'package:langpal/providers/question_type_provider.dart';

class NewQuestionScreen extends ConsumerStatefulWidget {
  const NewQuestionScreen({super.key});
  @override
  ConsumerState<NewQuestionScreen> createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends ConsumerState<NewQuestionScreen> {
  final questionTypeTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    questionTypeTextEditingController.text =
        ref.watch(questionTypeProvider).toKoreanName();
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
      ),
      body: SafeArea(
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
                      value: questionType, label: questionType.toKoreanName());
                }).toList(),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "질문을 입력하세요"),
                  keyboardType: TextInputType.text,
                  maxLines: 8,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("0"),
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
                  const Text("100"),
                ],
              ),
              const Spacer(),
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
                child: const Text(
                  "등록",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    questionTypeTextEditingController.dispose();
    super.dispose();
  }
}
