import 'package:flutter/material.dart';
//todo: RenenueCat, Adapty 라는 서비스가 있어요. 비슷한 서비스 다른것도 있으니 참고하세요. 
class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,//todo: Theme로 접근하면 좋을듯.
      appBar: AppBar(
        title: const Text(
          "프리미엄 구독",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,//todo: Theme로 접근하면 좋을듯. 
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
              const Text(
                "구독 요금제 선택",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "월간",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "* 매달 3,000 포인트 제공",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "* 질문 최상단 노출",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "₩5,900 / 월",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
                iconAlignment: IconAlignment.end,
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "연간",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "* 매달 4,000 포인트 제공",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "* 질문 최상단 노출",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "₩59,000 / 년",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
                iconAlignment: IconAlignment.end,
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text("다음으로"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
