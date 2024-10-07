import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String username;
  final String content;
  const AnswerCard({
    super.key,
    required this.username,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/profile.png",
                  width: 70,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                username,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
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
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
