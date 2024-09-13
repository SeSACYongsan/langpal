import 'package:flutter/material.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "프리미엄 구독",
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
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "구독 요금제 선택",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "월간",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "* 매달 3,000 포인트 제공",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "* 질문 최상단 노출",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "₩5,900 / 월",
                      style: Theme.of(context).textTheme.titleLarge,
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
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "연간",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "* 매달 4,000 포인트 제공",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "* 질문 최상단 노출",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "₩59,000 / 년",
                      style: Theme.of(context).textTheme.titleLarge,
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
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text("구독"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
