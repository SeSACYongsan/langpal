import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/answer_card_view_model.dart';

class AnswerCard extends ConsumerStatefulWidget {
  final Answer answer;
  final bool isProfileVisible;
  const AnswerCard({
    super.key,
    required this.answer,
    required this.isProfileVisible,
  });
  @override
  ConsumerState<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends ConsumerState<AnswerCard> {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(answerCardViewModelProvider);
    return asyncData.when(
      loading: () {
        return const LoadingScreen();
      },
      error: (error, stackTrace) {
        return ErrorScreen(message: error.toString());
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final owner = data["owner"] as LangpalUser;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.isProfileVisible)
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
                  child: Text(widget.answer.content),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ref
        .read(answerCardViewModelProvider.notifier)
        .fetchUserByAnswerID(widget.answer.id);
  }
}
