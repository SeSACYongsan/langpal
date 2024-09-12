import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:langpal/models/dummy_notifications.dart';

final dateFormatter = DateFormat.Hm();

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "알림",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_box_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  dateFormatter.format(dummyNotifications[index].date),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  dummyNotifications[index].content,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        itemCount: dummyNotifications.length,
      ),
    );
  }
}
