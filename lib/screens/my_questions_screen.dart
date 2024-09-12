import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyQuestionsScreen extends StatelessWidget {
  const MyQuestionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "나의 질문",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.go("/main/my_page/my_questions/detail/wow");
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                        "2024-07-31 15:14",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Break a leg",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "무슨 뜻인가요?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
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
