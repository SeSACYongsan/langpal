import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langpal/models/sign_in_status.dart';
import 'package:langpal/providers/current_user_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/earth.png",
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Placeholder();
            },
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Text(
                  "YOUR LANGUAGE MATE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoNarrow(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "LANGPAL",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivo(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      const Shadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final signInStatus = await ref
                                .read(currentUserProvider.notifier)
                                .signInWithGoogle();
                            switch (signInStatus) {
                              case SignInStatus.signInFailed:
                                showSignInFailedDialog(context);
                                break;
                              case SignInStatus.userNotExist:
                                context.go("/initialization");
                                break;
                              case SignInStatus.userExist:
                                context.go("/main");
                                break;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          icon: Image.asset(
                            "assets/images/google_logo.png",
                            width: 30,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                          label: Text(
                            "SIGN IN WITH GOOGLE",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.go("/initialization");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 10,
                          ),
                          icon: Image.asset(
                            "assets/images/apple_logo.png",
                            width: 30,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                          label: Text(
                            "SIGN IN WITH APPLE",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSignInFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          title: Text("로그인에 실패하였습니다."),
        );
      },
    );
  }
}
