import 'package:langpal/models/notification.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_view_model.g.dart';

@riverpod
class NotificationsViewModel extends _$NotificationsViewModel {
  late final NotificationRepository notificationRepository;
  @override
  Future<List<Notification>?> build() async {
    notificationRepository = NotificationRepository();
    return [];
  }

  Future<void> fetchMyNotifications() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final notifications =
        await notificationRepository.fetchNotificationsByUserID(currentUser.id);
    state = AsyncData(notifications);
  }
}