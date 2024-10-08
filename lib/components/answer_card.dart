import 'package:flutter/material.dart';
import 'package:langpal/models/answer.dart';
import 'package:langpal/models/langpal_user.dart';

class AnswerCard extends StatelessWidget {
  final LangpalUser user;
  final Answer answer;
  final bool isProfileVisible;
  const AnswerCard({
    super.key,
    required this.user,
    required this.answer,
    required this.isProfileVisible,
  });
  @override
  Widget build(BuildContext context) {
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
                    user.info.username,
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
  }
}
