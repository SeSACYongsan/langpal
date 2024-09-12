import 'package:flutter/material.dart';
import 'package:langpal/models/question_type.dart';

//todo: 이 페이지에서 keyboard up되었을때 overflow발생합니다. 
class NewQuestionScreen extends StatelessWidget {
  const NewQuestionScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DropdownMenu( //todo : dropdown button을 좀 더 이쁜 패키지를 찾아보면 좋겠어요.
                initialSelection: QuestionType.isNatural,
                expandedInsets: EdgeInsets.zero,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: QuestionType.isNatural, label: "이 표현은 자연스럽습니까?"),
                  DropdownMenuEntry(
                      value: QuestionType.difference, label: "차이점은 무엇입니까?"),
                  DropdownMenuEntry(
                      value: QuestionType.examples, label: "예문을 들어주세요."),
                  DropdownMenuEntry(
                      value: QuestionType.meaning, label: "무슨 뜻입니까?"),
                  DropdownMenuEntry(value: QuestionType.what, label: "무엇입니까?"),
                ],
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
                      value: 50,
                      min: 0,
                      max: 100,
                      thumbColor: Colors.blue,
                      activeColor: Colors.blue,
                      onChanged: (newValue) {},
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
}
