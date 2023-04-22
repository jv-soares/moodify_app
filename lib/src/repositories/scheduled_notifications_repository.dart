// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/scheduled_notification.dart';

abstract class ScheduledNotificationsRepository {
  Future<List<ScheduledNotification>> readAll();
  Future<String> create(ScheduledNotification notification);
  Future<void> toggle(String id, bool isActive);
  Future<void> delete(String id);
}

class TempScheduledNotificationRepository
    implements ScheduledNotificationsRepository {
  final _notifications = [
    ScheduledNotification('1', TimeOfDay(hour: 12, minute: 0), true),
    ScheduledNotification('2', TimeOfDay(hour: 23, minute: 10), true),
    ScheduledNotification('3', TimeOfDay(hour: 10, minute: 5), false),
    ScheduledNotification('4', TimeOfDay(hour: 14, minute: 30), false),
  ];

  @override
  Future<String> create(ScheduledNotification notification) async {
    await _delay;
    _notifications.add(notification);
    return notification.id;
  }

  @override
  Future<void> delete(String id) async {
    await _delay;
    _notifications.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<ScheduledNotification>> readAll() async {
    await _delay;
    return _notifications;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> toggle(String id, bool isActive) async {
    await _delay;
    final index = _notifications.indexWhere((element) => element.id == id);
    _notifications[index] = _notifications[index].copyWith(isActive: isActive);
  }
}
