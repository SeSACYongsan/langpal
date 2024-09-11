import 'package:go_router/go_router.dart';
import 'package:langpal/screens/sign_in_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
