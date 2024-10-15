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

  Future<int> fetchNumberOfCheckedCheckboxes() async {
    final checkboxes = state.value!["checkboxes"] as List<bool>;
    final numberOfCheckedCheckboxes = checkboxes.where((checkbox) {
      return checkbox;
    }).length;
    return numberOfCheckedCheckboxes;
  }

  Future<void> updateCheckboxes(
      {required int index, required bool? value}) async {
    List<bool> checkboxes = state.value!["checkboxes"];
    checkboxes[index] = value!;
    state = AsyncData({
      "notifications": state.value!["notifications"],
      "checkboxes": checkboxes,
    });
  }
}
