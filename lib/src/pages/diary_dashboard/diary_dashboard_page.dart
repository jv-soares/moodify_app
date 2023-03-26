import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';

import 'components/diary_entry_draggable_bottom_sheet.dart';

class DiaryDashboardPage extends StatelessWidget {
  DiaryDashboardPage({super.key});

  final notifier = DiaryDashboardNotifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: notifier,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        appBar: AppBar(
          title: AnimatedBuilder(
            animation: notifier,
            builder: (context, _) => Text(
              DateFormat.yMMMM().format(
                notifier.selectedEntry?.createdAt ?? DateTime.now(),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            EpisodesChart(),
            DiaryEntryDraggableBottomSheet(),
          ],
        ),
      ),
    );
  }
}
