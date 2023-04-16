import 'package:flutter/material.dart';

import '../../../models/scheduled_notification.dart';

class ScheduledNotificationListTile extends StatelessWidget {
  final ScheduledNotification notification;
  final ValueChanged<bool> onChanged;

  const ScheduledNotificationListTile(
    this.notification, {
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        notification.time.format(context),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: Switch(value: notification.isActive, onChanged: onChanged),
    );
  }
}
