import 'package:flutter/material.dart';

import '../../../models/scheduled_notification.dart';

class NotificationsNotifier extends ValueNotifier<List<ScheduledNotification>> {
  NotificationsNotifier() : super(notifications);

  void toggleNotification(String id, bool isActive) {
    final list = [...value];
    final index = list.indexWhere((e) => e.id == id);
    list[index] = list[index].copyWith(isActive: isActive);
    value = list;
  }

  Future<void> createAt(TimeOfDay time) async {
    final notification = ScheduledNotification('example', time, true);
    value = [...value, notification];
  }
}

const notifications = [
  ScheduledNotification('1', TimeOfDay(hour: 12, minute: 0), true),
  ScheduledNotification('2', TimeOfDay(hour: 23, minute: 10), true),
  ScheduledNotification('3', TimeOfDay(hour: 10, minute: 5), false),
  ScheduledNotification('4', TimeOfDay(hour: 14, minute: 30), false),
];
