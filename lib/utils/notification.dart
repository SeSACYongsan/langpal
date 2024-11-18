import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FlutterLocalNotification._();
  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "Channel ID",
      "Channel Name",
      channelDescription: "Channel Description",
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Test title",
      "Test body",
      notificationDetails,
    );
  }
}
