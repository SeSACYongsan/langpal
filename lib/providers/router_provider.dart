import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/providers/questions_provider.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/initialization_screen.dart';
import 'package:langpal/screens/main_screen.dart';
import 'package:langpal/screens/my_answer_detail_screen.dart';
import 'package:langpal/screens/my_answers_screen.dart';
import 'package:langpal/screens/my_page_screen.dart';
import 'package:langpal/screens/my_question_detail_screen.dart';
import 'package:langpal/screens/my_questions_screen.dart';
import 'package:langpal/screens/new_question_screen.dart';
import 'package:langpal/screens/notifications_screen.dart';
import 'package:langpal/screens/profile_setting_screen.dart';
import 'package:langpal/screens/question_detail_screen.dart';
import 'package:langpal/screens/sign_in_screen.dart';
import 'package:langpal/screens/subscription_plans_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: "/initialization",
        builder: (context, state) => const InitializationScreen(),
      ),
      GoRoute(
        path: "/profile_setting",
        builder: (context, state) => const ProfileSettingScreen(),
      ),
      GoRoute(
        path: "/main",
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
            path: "questions/:question_id",
            builder: (context, state) {
              final questionID = state.pathParameters["question_id"];
              ref
                  .read(questionsProvider.notifier)
                  .getQuestionByID(questionID!)
                  .then((question) {
                if (question != null) {
                  return QuestionDetailScreen(question: question);
                } else {
                  return const ErrorScreen();
                }
              }, onError: (error) {
                print("Error: $error");
                return const ErrorScreen();
              });
              return const ErrorScreen();
            },
          ),
          GoRoute(
            path: "notifications",
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: "my_page",
            builder: (context, state) => const MyPageScreen(),
            routes: [
              GoRoute(
                path: "my_questions",
                builder: (context, state) => const MyQuestionsScreen(),
                routes: [
                  GoRoute(
                    path: "detail/:question_id",
                    builder: (context, state) => const MyQuestionDetailScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: "my_answers",
                builder: (context, state) => const MyAnswersScreen(),
                routes: [
                  GoRoute(
                    path: "detail/:answer_id",
                    builder: (context, state) => const MyAnswerDetailScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: "subscription",
                builder: (context, state) => const SubscriptionPlansScreen(),
              ),
            ],
          ),
          GoRoute(
            path: "new_question",
            builder: (context, state) => const NewQuestionScreen(),
          ),
        ],
      ),
    ],
  );
});
