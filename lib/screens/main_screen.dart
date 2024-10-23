import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/components/question_card.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/router.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/main_view_model.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with RouteAwareMixin {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(mainViewModelProvider);
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
          final questions = data["questions"] as List<Question>;
          final profilePhotos = data["profilePhotos"] as List<Uint8List?>;
          return Scaffold(
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
                  onPressed: () {
                    context.go("/main/notifications");
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.go("/main/my_page");
                },
              ),
            ),
            body: questions.isEmpty
                ? Center(
                    child: Text(
                      "질문이 없어요",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => QuestionCard(
                      question: questions[index],
                      route: "/main/questions/${questions[index].id}",
                      profilePhoto: profilePhotos[index],
                      isProfileVisible: true,
                    ),
                    itemCount: questions.length,
                  ),
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.go("/main/new_question");
              },
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void didPopNext() {
    ref.read(mainViewModelProvider.notifier).fetchUnchosenQuestions();
    super.didPopNext();
  }

  @override
  void didPush() {
    ref.read(mainViewModelProvider.notifier).fetchUnchosenQuestions();
    super.didPush();
  }

  @override
  void initState() {
    ref.read(mainViewModelProvider.notifier).fetchUnchosenQuestions();
    super.initState();
  }
}
