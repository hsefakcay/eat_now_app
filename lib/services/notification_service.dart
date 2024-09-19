// notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    var androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flp.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String message) async {
    var androidNotificationDetails = const AndroidNotificationDetails(
      "id",
      "name",
      channelDescription: "channelDescription",
      priority: Priority.high,
      importance: Importance.max,
    );

    var iosNotificationDetails = const DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await flp.show(0, title, message, notificationDetails);
  }
}
