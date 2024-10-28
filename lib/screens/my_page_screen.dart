import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/router.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/my_page_view_model.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  const MyPageScreen({super.key});
  @override
  ConsumerState<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen>
    with RouteAwareMixin {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(myPageViewModelProvider);
    return asyncData.when(
      loading: () {
        return const LoadingScreen();
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final user = data["currentUser"] as LangpalUser;
          final profilePhoto = data["profilePhoto"] as Uint8List?;
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
                  context.go("/main");
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
                    if (profilePhoto == null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset(
                          "assets/images/profile.png",
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person);
                          },
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 150,
                        backgroundImage: MemoryImage(profilePhoto),
                      ),
                    const SizedBox(height: 30),
                    Text(
                      "${user.info.username} (${user.isPremium ? "프리미엄 회원" : "일반 회원"})",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${user.point} 포인트",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "배우는 언어: ${user.info.targetLanguage.toKoreanName()}",
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
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        textStyle:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
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
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        await onTapCancelSubscription();
                      },
                      child: Text(
                        "구독 취소",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        await onTapSignOut(context);
                      },
                      child: Text(
                        "로그아웃",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void didPopNext() {
    ref.read(myPageViewModelProvider.notifier).fetchCurrentUser();
    super.didPopNext();
  }

  @override
  void didPush() {
    ref.read(myPageViewModelProvider.notifier).fetchCurrentUser();
    super.didPush();
  }

  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(myPageViewModelProvider.notifier).fetchCurrentUser();
    });
  }

  Future<void> onTapCancelSubscription() async {
    await ref.read(myPageViewModelProvider.notifier).demoteCurrentUser();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("구독이 취소되었습니다"),
      ),
    );
  }

  Future<void> onTapSignOut(BuildContext context) async {
    await ref.read(myPageViewModelProvider.notifier).signOut();
    if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("성공적으로 로그아웃하였습니다"),
        ),
      );
      context.go("/");
    }
  }
}
