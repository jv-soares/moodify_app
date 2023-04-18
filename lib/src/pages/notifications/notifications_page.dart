import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/moodify_divider.dart';
import 'components/scheduled_notification_list_tile.dart';
import 'notifiers/notifications_notifier.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _notifier = NotificationsNotifier(
    listKey: GlobalKey<SliverAnimatedListState>(),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _notifier,
      child: Scaffold(
        appBar: AppBar(title: const Text('Notificações')),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _ExplanationContainer()),
            ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (context, notifications, _) => SliverAnimatedList(
                key: _notifier.listKey,
                initialItemCount: notifications.length,
                itemBuilder: (context, index, animation) {
                  bool isLastIndex() {
                    return index < notifications.length - 1;
                  }

                  final item = notifications[index];
                  return SlideTransition(
                    position: animation.drive(Tween(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    )),
                    child: Container(
                      decoration: isLastIndex()
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ),
                            )
                          : null,
                      child: ScheduledNotificationListTile(
                        key: ValueKey(item.id),
                        item,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
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
              onPressed: () {
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
