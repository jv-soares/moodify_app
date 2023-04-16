import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: ListView.separated(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications.sortedByTimeOfDay()[index];
          return ListTile(
            title: Text(
              item.time.format(context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          );
        },
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
      ),
    );
  }
}

class ScheduledNotification {
  final String id;
  final TimeOfDay time;
  final bool isActive;

  const ScheduledNotification(this.id, this.time, this.isActive);
}

const notifications = [
  ScheduledNotification('1', TimeOfDay(hour: 12, minute: 0), true),
  ScheduledNotification('2', TimeOfDay(hour: 23, minute: 10), true),
  ScheduledNotification('3', TimeOfDay(hour: 10, minute: 5), false),
  ScheduledNotification('4', TimeOfDay(hour: 14, minute: 30), false),
];

extension on List<ScheduledNotification> {
  List<ScheduledNotification> sortedByTimeOfDay() {
    return sortedByCompare((e) => e.time, (a, b) {
      final result = a.hour.compareTo(b.hour);
      if (result == 0) return a.minute.compareTo(b.minute);
      return result;
    });
  }
}
