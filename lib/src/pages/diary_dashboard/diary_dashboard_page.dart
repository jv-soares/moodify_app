import 'package:flutter/material.dart';
import 'package:moodify_app/src/diary_entries.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';

import 'components/diary_entry_draggable_bottom_sheet.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiaryDashboardNotifier(),
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
          title: const Text('Janeiro de 2023'),
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
