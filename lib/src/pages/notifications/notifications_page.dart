import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/notifications/components/scheduled_notification_list_tile.dart';
import 'package:provider/provider.dart';

import '../../models/scheduled_notification.dart';
import '../../utils/list_extension.dart';
import '../../widgets/moodify_divider.dart';
import 'notifiers/notifications_notifier.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _notifier = NotificationsNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _notifier,
      child: Scaffold(
        appBar: AppBar(title: const Text('Notificações')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _ExplanationContainer(),
              ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (context, notifications, _) => Column(
                  children: notifications
                      .sortedByTimeOfDay()
                      .map<Widget>(
                        (e) => ScheduledNotificationListTile(
                          e,
                          key: ValueKey(e.id),
                          onChanged: (value) {
                            _notifier.toggleNotification(e.id, value);
                          },
                        ),
                      )
                      .toList()
                      .separatedBy(const MoodifyDivider()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplanationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personalize suas notificações',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: onPrimaryContainer),
              ),
              Text(
                'Defina os horários dos lembretes diários',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: onPrimaryContainer),
              ),
            ],
          ),
          MoodifyDivider(
            verticalMargin: 6,
            horizontalMargin: 0,
            color: Theme.of(context).colorScheme.primary.withOpacity(.3),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((pickedTime) {
                  if (pickedTime != null) {
                    context.read<NotificationsNotifier>().createAt(pickedTime);
                  }
                });
              },
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('ADICIONAR NOTIFICAÇÃO'),
            ),
          ),
        ],
      ),
    );
  }
}
