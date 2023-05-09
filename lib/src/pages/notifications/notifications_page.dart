import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/scheduled_notification.dart';
import 'package:provider/provider.dart';

import '../../widgets/fetch_notifier_builder.dart';
import '../../widgets/moodify_divider.dart';
import 'components/scheduled_notification_list_tile.dart';
import 'notifiers/notifications_notifier.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsNotifier _notifier;
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    _notifier = NotificationsNotifier(
      listKey: GlobalKey<SliverAnimatedListState>(),
      removedItemBuilder: removedItemBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _notifier,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Notificações'),
          actions: [
            FetchNotifierBuilder(
              notifier: _notifier,
              onSuccess: (data) => data.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() => _editMode = !_editMode);
                      },
                      icon: Icon(_editMode ? Icons.check : Icons.edit),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        body: FetchNotifierBuilder(
          notifier: _notifier,
          onLoading: () => const Center(child: CircularProgressIndicator()),
          onSuccess: (data) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _ExplanationContainer()),
              SliverAnimatedList(
                key: _notifier.listKey,
                initialItemCount: data.length,
                itemBuilder: (context, index, animation) {
                  bool isLastIndex() {
                    return index < data.length - 1;
                  }

                  final item = data[index];
                  return _buildWithSlideTransition(
                    Container(
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
                        isEditing: _editMode,
                        item,
                      ),
                    ),
                    animation,
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 48)),
            ],
          ),
        ),
      ),
    );
  }

  Widget removedItemBuilder(
    BuildContext context,
    ScheduledNotification item,
    Animation<double> animation,
  ) {
    return _buildWithSlideTransition(
      ScheduledNotificationListTile(
        key: ValueKey(item.id),
        isEditing: _editMode,
        item,
      ),
      animation,
    );
  }

  Widget _buildWithSlideTransition(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeInOutQuad),
        ),
      ),
      child: child,
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
            children: [
              Text(
                'Crie notificações personalizadas',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: onPrimaryContainer),
              ),
              const SizedBox(height: 4),
              Text(
                'Você pode definir um horário para não se esquecer de preencher o diário',
                textAlign: TextAlign.center,
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
              child: const Text('CRIAR NOTIFICAÇÃO'),
            ),
          ),
        ],
      ),
    );
  }
}
