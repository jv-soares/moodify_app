import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../widgets/home_app_bar.dart';
import 'components/diary_entry_draggable_bottom_sheet.dart';
import 'components/episodes_chart.dart';
import 'notifiers/diary_dashboard_notifier.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: notifier.canAddEntry
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.diaryForm);
              },
            )
          : null,
      appBar: const HomeAppBar(),
      body: Stack(
        children: const [
          EpisodesChart(),
          DiaryEntryDraggableBottomSheet(),
        ],
      ),
    );
  }
}
