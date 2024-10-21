import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:langpal/models/notification.dart' as model;
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/notifications_view_model.dart';

final dateFormatter = DateFormat.yMd();

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});
  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool isCheckboxChecked = false;
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(notificationsViewModelProvider);
    return asyncData.when(
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final notifications =
              data["notifications"] as List<model.Notification>;
          final checkboxes = data["checkboxes"] as List<bool>;
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
                  context.go("/main");
                },
              ),
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  onPressed: onTapCheckbox,
                  icon: const Icon(
                    Icons.check_box_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: notifications.isEmpty
                ? Center(
                    child: Text(
                      "알림이 없어요",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          if (isCheckboxChecked)
                            Checkbox(
                              value: checkboxes[index],
                              onChanged: (value) {
                                onCheckboxChanged(value: value, index: index);
                              },
                            ),
                          Expanded(
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
                                    dateFormatter
                                        .format(notifications[index].date),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    notifications[index].content,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: notifications.length,
                  ),
          );
        }
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      loading: () {
        return const LoadingScreen();
      },
    );
  }

  @override
  void initState() {
    ref.read(notificationsViewModelProvider.notifier).fetchMyNotifications();
    super.initState();
  }

  void onCheckboxChanged({required bool? value, required int index}) {
    ref
        .read(notificationsViewModelProvider.notifier)
        .updateCheckboxes(index: index, value: value);
  }

  void onTapCheckbox() async {
    final numberOfCheckedCheckboxes = ref
        .read(notificationsViewModelProvider.notifier)
        .fetchNumberOfCheckedCheckboxes();
    if (isCheckboxChecked && numberOfCheckedCheckboxes != 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$numberOfCheckedCheckboxes건의 알림을 읽음으로 처리하겠어요?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await ref
                        .read(notificationsViewModelProvider.notifier)
                        .setRead();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("예")),
              TextButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("아니요")),
            ],
          );
        },
      );
    } else if (isCheckboxChecked && numberOfCheckedCheckboxes == 0) {
      setState(() {
        isCheckboxChecked = false;
      });
    } else {
      setState(() {
        isCheckboxChecked = true;
      });
    }
  }
}
