import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/answer_card_view_model.dart';

class AnswerCard extends ConsumerWidget {
  final Answer answer;
  final bool isProfileVisible;
  const AnswerCard({
    super.key,
    required this.answer,
    required this.isProfileVisible,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureOwner = ref
        .read(answerCardViewModelProvider.notifier)
        .fetchUserByAnswerID(answer.id);
    return FutureBuilder(
      future: futureOwner,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return ErrorScreen(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          final owner = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isProfileVisible)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/profile.png",
                            width: 70,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 70,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          owner.info.username,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(3, 3),
                        color: Colors.black12,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Text(answer.content),
                ),
              ],
            ),
          );
        } else {
          return const ErrorScreen(message: "The snapshot is null");
        }
      },
    );
  }
}
