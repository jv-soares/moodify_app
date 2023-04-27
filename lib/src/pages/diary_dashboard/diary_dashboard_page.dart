import 'package:flutter/material.dart';

import '../../app.dart';
import '../../widgets/home_app_bar.dart';
import 'components/diary_entry_draggable_bottom_sheet.dart';
import 'components/episodes_chart.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.diaryForm);
        },
      ),
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
