import 'package:flutter/material.dart';

class MyAnswerDetailScreen extends StatelessWidget {
  const MyAnswerDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "나의 답변",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
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
                    )
                  ],
                  color: Colors.white,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("\"뉴진스 사랑해\""),
                    Text("이 표현은 자연스럽나요?"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "나의 답변",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
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
                    )
                  ],
                ),
                child: const Text("자연스러워요 ^^"),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {},
                child: const Text("수정하기"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
