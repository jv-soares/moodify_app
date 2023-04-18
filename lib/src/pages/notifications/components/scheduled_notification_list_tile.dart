import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/notifications/notifiers/notifications_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/scheduled_notification.dart';

class ScheduledNotificationListTile extends StatelessWidget {
  final ScheduledNotification notification;

  const ScheduledNotificationListTile(this.notification, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: Text(
        notification.time.format(context),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: Switch(
        value: notification.isActive,
        onChanged: (value) => context
            .read<NotificationsNotifier>()
            .toggleNotification(notification.id, value),
      ),
    );
  }
}
