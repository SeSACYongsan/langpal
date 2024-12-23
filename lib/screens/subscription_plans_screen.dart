import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/view_models/subscription_plans_view_model.dart';

class SubscriptionPlansScreen extends ConsumerStatefulWidget {
  const SubscriptionPlansScreen({super.key});
  @override
  ConsumerState<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState
    extends ConsumerState<SubscriptionPlansScreen> {
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
                onPressed: () async {
                  await onTapMonthlyPlan();
                },
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
                onPressed: () async {
                  await onTapAnnualPlan();
                },
                iconAlignment: IconAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapAnnualPlan() async {
    await ref
        .read(subscriptionPlansViewModelProvider.notifier)
        .promoteCurrentUser();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("프리미엄 회원이 되었습니다"),
      ),
    );
    context.go("/main/my_page");
  }

  Future<void> onTapMonthlyPlan() async {
    await ref
        .read(subscriptionPlansViewModelProvider.notifier)
        .promoteCurrentUser();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("프리미엄 회원이 되었습니다"),
      ),
    );
    context.go("/main/my_page");
  }
}
