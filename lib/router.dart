import 'package:go_router/go_router.dart';
import 'package:langpal/screens/initialization_screen.dart';
import 'package:langpal/screens/main_screen.dart';
import 'package:langpal/screens/profile_setting_screen.dart';
import 'package:langpal/screens/question_detail_screen.dart';
import 'package:langpal/screens/sign_in_screen.dart';

final router = GoRouter(
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
          path: "detail/:question_id",
          builder: (context, state) {
            return const QuestionDetailScreen();
          },
        )
      ],
    ),
  ],
);
