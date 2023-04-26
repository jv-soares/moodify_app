import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/moodify_draggable_bottom_sheet.dart';
import '../diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'components/statistics_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    if (notifier.state is Loaded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Estatísticas'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (notifier.state is Loaded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
                height: MediaQuery.of(context).size.height / 3.5,
                child: const StatisticsChart(),
              ),
            if (notifier.state is Loading) const CircularProgressIndicator(),
            MoodifyDraggableBottomSheet(
              initialChildSize: .6,
              minChildSize: .6,
              content: Column(),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
