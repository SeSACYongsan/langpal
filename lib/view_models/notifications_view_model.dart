import 'package:langpal/models/notification.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
class NotificationsViewModel extends _$NotificationsViewModel {
  late final NotificationRepository notificationRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    notificationRepository = NotificationRepository();
    return null;
  }

  Future<void> fetchMyNotifications() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final notifications =
        await notificationRepository.fetchNotificationsByUserID(currentUser.id);
    state = AsyncData({
      "notifications": notifications,
      "checkboxes": List.generate(notifications!.length, (_) => false),
    });
  }

  int fetchNumberOfCheckedCheckboxes() {
    final checkboxes = state.value!["checkboxes"] as List<bool>;
    final numberOfCheckedCheckboxes = checkboxes.where((checkbox) {
      return checkbox;
    }).length;
    return numberOfCheckedCheckboxes;
  }

  Future<void> setRead() async {
    final checkboxes = state.value!["checkboxes"] as List<bool>;
    final notifications = state.value!["notifications"] as List<Notification>;
    List<Notification> targetNotifications = [];
    List<Notification> remainingNotifications = [];
    List.generate(notifications.length, (index) {
      if (checkboxes[index]) {
        targetNotifications.add(notifications[index]);
      } else {
        remainingNotifications.add(notifications[index]);
      }
    });
    await notificationRepository.removeNotifications(targetNotifications);
    state = AsyncData({
      "checkboxes": List.generate(remainingNotifications.length, (_) => false),
      "notifications": remainingNotifications,
    });
  }

  void updateCheckboxes({required int index, required bool? value}) {
    List<bool> checkboxes = state.value!["checkboxes"];
    checkboxes[index] = value!;
    state = AsyncData({
      "notifications": state.value!["notifications"],
      "checkboxes": checkboxes,
    });
  }
}
