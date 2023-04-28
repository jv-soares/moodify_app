import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moodify_app/src/app.dart';
import 'package:moodify_app/src/app_container.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../core/app_navigator.dart';

class LocalNotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  final _navigator = AppContainer.get<AppNavigator>();

  LocalNotificationService._() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  }

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
      onDidReceiveNotificationResponse: (_) {
        _navigator.state.pushNamed(AppRoutes.diaryForm);
      },
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future<void> show({required int id, String? title, String? body}) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'default-notification-channel',
      'Default channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _plugin.show(id, title, body, notificationDetails);
  }

  Future<void> scheduleDaily({
    required int id,
    required TimeOfDay timeOfDay,
    String? title,
    String? body,
  }) async {
    final scheduledDate = DateTime.now().copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled-notification-channel',
          'Scheduled channel',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id);
}

void _onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  final navigator = AppContainer.get<AppNavigator>();
  navigator.state.pushNamed(AppRoutes.diaryForm);
}
