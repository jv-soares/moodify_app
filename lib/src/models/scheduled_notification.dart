import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ScheduledNotification {
  final String id;
  final TimeOfDay time;
  final bool isActive;

  const ScheduledNotification(this.id, this.time, this.isActive);
}

extension ScheduledNotificationListX on List<ScheduledNotification> {
  List<ScheduledNotification> sortedByTimeOfDay() {
    return sortedByCompare((e) => e.time, (a, b) {
      final result = a.hour.compareTo(b.hour);
      if (result == 0) return a.minute.compareTo(b.minute);
      return result;
    });
  }
}
