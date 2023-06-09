import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/notifications/notifiers/notifications_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/scheduled_notification.dart';

class ScheduledNotificationListTile extends StatelessWidget {
  final ScheduledNotification notification;
  final bool isEditing;

  const ScheduledNotificationListTile(
    this.notification, {
    super.key,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: Text(
        notification.time.format(context),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: isEditing
          ? IconButton(
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.errorContainer,
              ),
              onPressed: () {
                context.read<NotificationsNotifier>().delete(notification.id);
              },
              icon: Icon(
                Icons.delete_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
            )
          : Switch(
              value: notification.isActive,
              onChanged: (value) => context
                  .read<NotificationsNotifier>()
                  .toggleNotification(notification.id, value),
            ),
    );
  }
}
