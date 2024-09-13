import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "마이페이지",
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
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset("assets/images/profile.png"),
                ),
                const SizedBox(height: 30),
                Text(
                  "jinwookkim (일반 회원)",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "330 포인트",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "배우는 언어: 영어",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    context.go("/main/my_page/my_questions");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    elevation: 3,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  label: const Text(
                    "나의 질문 보기",
                  ),
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  iconAlignment: IconAlignment.end,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    context.go("/main/my_page/my_answers");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  label: const Text("나의 답변 보기"),
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  iconAlignment: IconAlignment.end,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    context.go("/main/my_page/subscription");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  label: const Text("프리미엄 구독"),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  iconAlignment: IconAlignment.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
