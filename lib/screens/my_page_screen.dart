import 'package:flutter/material.dart';

//todo: 프리미엄 구독 취소는 어디서??
//todo: billing history못 보나요?
//todo: button background 색상이라도 좀 바꿔보면 덜 지루할것 같아요.
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
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
        ),
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
                const Text(
                  "jinwookkim (일반 회원)",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "330 포인트",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "배우는 언어: 영어",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    elevation: 3,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  label: const Text("나의 질문 보기"),
                  icon: const Icon(Icons.chevron_right),
                  iconAlignment: IconAlignment.end,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    elevation: 3,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  label: const Text("나의 답변 보기"),
                  icon: const Icon(Icons.chevron_right),
                  iconAlignment: IconAlignment.end,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    elevation: 3,
                    textStyle: const TextStyle(
                      fontSize: 16,
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
