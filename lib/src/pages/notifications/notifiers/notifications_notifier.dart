import 'package:flutter/material.dart';
import 'package:moodify_app/src/app_container.dart';
import 'package:moodify_app/src/repositories/scheduled_notifications_repository.dart';

import '../../../models/fetch_notifier.dart';
import '../../../models/scheduled_notification.dart';

typedef RemovedItemBuilder = Widget Function(
  BuildContext,
  ScheduledNotification,
  Animation<double>,
);

class NotificationsNotifier extends FetchNotifier<List<ScheduledNotification>> {
  final _repository = AppContainer.get<ScheduledNotificationsRepository>();

  final GlobalKey<SliverAnimatedListState> listKey;
  final RemovedItemBuilder removedItemBuilder;

  NotificationsNotifier({
    required this.listKey,
    required this.removedItemBuilder,
  }) {
    _initialize();
  }

  List<ScheduledNotification> get _values => data ?? [];

  Future<void> _initialize() {
    return fetch(
      () => _repository.readAll().then((items) => items.sortedByTimeOfDay()),
    );
  }

  void toggleNotification(String id, bool isActive) {
    final list = [..._values];
    final index = list.indexWhere((e) => e.id == id);
    list[index] = list[index].copyWith(isActive: isActive);
    data = list;
    _repository.toggle(id, isActive);
  }

  Future<void> createAt(TimeOfDay time) async {
    var notification = ScheduledNotification(time.toString(), time, true);
    final id = await _repository.create(notification);
    notification = notification.copyWith(id: id);
    final list = [..._values, notification].sortedByTimeOfDay();
    data = list;
    final index = list.indexWhere((element) => element.time == time);
    listKey.currentState?.insertItem(index);
  }

  void delete(String id) {
    final list = [..._values];
    final index = list.indexWhere((element) => element.id == id);
    final removedItem = list.removeAt(index);
    data = list;
    listKey.currentState?.removeItem(
      index,
      (context, animation) => removedItemBuilder(
        context,
        removedItem,
        animation,
      ),
    );
    _repository.delete(id);
  }
}
