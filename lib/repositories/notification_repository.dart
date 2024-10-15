import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/notification.dart';
import 'package:langpal/utils/logger.dart';

class NotificationRepository {
  Future<void> addNotification(Notification notification) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("notifications")
        .doc(notification.id)
        .set(notification.toJson());
  }

  Future<List<Notification>?> fetchNotificationsByUserID(String userID) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final notificationsSnapshot = await firestoreInstance
        .collection("notifications")
        .where("ownerID", isEqualTo: userID)
        .get();
    try {
      final notifications = notificationsSnapshot.docs.map((document) {
        if (document.exists) {
          return Notification.fromJson(document.data());
        } else {
          throw Exception("The notification doesn't exist");
        }
      }).toList();
      notifications.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return notifications;
    } catch (error) {
      logger.e(error);
    }
    return null;
  }

  Future<void> removeNotifications(List<Notification> notifications) async {
    final firestoreInstance = FirebaseFirestore.instance;
    for (final notification in notifications) {
      await firestoreInstance
          .collection("notifications")
          .doc(notification.id)
          .delete();
    }
  }
}
