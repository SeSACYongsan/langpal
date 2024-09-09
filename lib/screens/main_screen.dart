import 'package:flutter/material.dart';
import 'package:langpal/models/dummy_questions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "답변하기",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/images/profile.png", width: 70),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dummyQuestions[index].owner),
                            Text("${dummyQuestions[index].point.toString()}pt"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(dummyQuestions[index].content)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        itemCount: dummyQuestions.length,
      ),
      backgroundColor: Colors.white,
    );
  }
}
