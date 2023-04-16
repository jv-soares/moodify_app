import 'package:flutter/material.dart';

import '../../models/scheduled_notification.dart';
import '../../utils/list_extension.dart';
import '../../widgets/moodify_divider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personalize suas notificações',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  Text(
                    'Aqui vc pode coisar',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
            ...notifications
                .sortedByTimeOfDay()
                .map<Widget>(
                  (e) => ListTile(
                    title: Text(
                      e.time.format(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                )
                .toList()
                .separatedBy(const MoodifyDivider()),
          ],
        ),
      ),
    );
  }
}

const notifications = [
  ScheduledNotification('1', TimeOfDay(hour: 12, minute: 0), true),
  ScheduledNotification('2', TimeOfDay(hour: 23, minute: 10), true),
  ScheduledNotification('3', TimeOfDay(hour: 10, minute: 5), false),
  ScheduledNotification('4', TimeOfDay(hour: 14, minute: 30), false),
];
