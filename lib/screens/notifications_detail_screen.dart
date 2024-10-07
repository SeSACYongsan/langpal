import 'package:flutter/material.dart';

class NotificationsDetailScreen extends StatelessWidget {
  const NotificationsDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "알림",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "읽음",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        leading: TextButton(
          onPressed: () {},
          child: const Text(
            "취소",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: false, onChanged: (newValue) {}),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Colors.black12,
                        offset: Offset(5, 5),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text([][index].date.toString()),
                      const SizedBox(height: 10),
                      Text([][index].content),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        itemCount: [].length,
      ),
    );
  }
}
