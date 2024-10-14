import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langpal/models/notification.dart';
import 'package:langpal/utils/logger.dart';

class NotificationRepository {
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
      return notifications;
    } catch (error) {
      logger.e(error);
    }
    return null;
  }
}
