import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  LocalNotificationService._();

  static Future<LocalNotificationService> getInstance() async {
    final instance = LocalNotificationService._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }

  Future<void> show({required int id, String? title, String? body}) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'diary_entry',
      'Diary entry channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _plugin.show(id, title, body, notificationDetails);
  }
}
