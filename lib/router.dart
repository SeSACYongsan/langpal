import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:langpal/screens/question_edit_screen.dart';
import 'package:langpal/screens/sign_in_screen.dart';
import 'package:langpal/screens/subscription_plans_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  observers: [routeObserver],
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
            if (questionID == null) {
              return const ErrorScreen(
                error: "The question id is null for some reason",
              );
            } else {
              return QuestionDetailScreen(questionID: questionID);
            }
          },
          routes: [
            GoRoute(
              path: "edit",
              builder: (context, state) {
                final questionID = state.pathParameters["question_id"];
                if (questionID == null) {
                  return const ErrorScreen(
                      error: "The question id is null for some reason");
                } else {
                  return QuestionEditScreen(questionID: questionID);
                }
              },
            ),
          ],
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
                  builder: (context, state) {
                    final questionID = state.pathParameters["question_id"];
                    if (questionID != null) {
                      return MyQuestionDetailScreen(
                        questionID: questionID,
                      );
                    } else {
                      return const ErrorScreen(
                          error: "The question id is null for some reason");
                    }
                  },
                  routes: [
                    GoRoute(
                      path: "edit",
                      builder: (context, state) {
                        final questionID = state.pathParameters["question_id"];
                        if (questionID != null) {
                          return QuestionEditScreen(questionID: questionID);
                        } else {
                          return const ErrorScreen(
                              error: "The question id is null for some reason");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: "my_answers",
              builder: (context, state) => const MyAnswersScreen(),
              routes: [
                GoRoute(
                  path: "detail/:answer_id",
                  builder: (context, state) {
                    final answerID = state.pathParameters["answer_id"];
                    if (answerID == null) {
                      return const ErrorScreen(
                          error: "The answer id is null for some reason");
                    } else {
                      return MyAnswerDetailScreen(answerID: answerID);
                    }
                  },
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

mixin RouteAwareMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  @override
  void didPop() {}

  @override
  void didPopNext() {}

  @override
  void didPush() {}

  @override
  void didPushNext() {}

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
  }
}
