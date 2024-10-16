import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final String route;
  const QuestionCard({
    super.key,
    required this.question,
    required this.route,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.go(route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                      color: Colors.black12,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          question.ownerUsername,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${question.point.toStringAsFixed(0)}pt",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      question.content,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
