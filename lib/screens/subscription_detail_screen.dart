import 'package:flutter/material.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "프리미엄 구독",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "구독료 결제",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "연간",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text("* 매달 4,000 포인트 제공"),
                    Text("* 질문 최상단 노출"),
                    Text(
                      "₩59,000 / 년",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: "소유자"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "CVV",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "카드 번호",
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: "만료 날짜",
                ),
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
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {},
                child: const Text("결제"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
