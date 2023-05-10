import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/episode_severity.dart';

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<DiaryDashboardNotifier>();
    final entries = (notifier.state as Loaded)
        .entries
        .map((e) => e.diaryEntry)
        .whereNotNull()
        .toList();
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: entries
                .map((e) => FlSpot(
                      e.createdAt.millisecondsSinceEpoch.toDouble(),
                      e.moodRating.toDouble(),
                    ))
                .toList(),
            isStrokeCapRound: true,
            isCurved: true,
            barWidth: 4,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: entries
                .map((e) => FlSpot(
                      e.createdAt.millisecondsSinceEpoch.toDouble(),
                      e.hoursOfSleep * 10,
                    ))
                .toList(),
            isStrokeCapRound: true,
            isCurved: true,
            barWidth: 4,
            color: Theme.of(context).colorScheme.primaryContainer,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: entries
                .map((e) => FlSpot(
                      e.createdAt.millisecondsSinceEpoch.toDouble(),
                      _calculateEpisodeSeverityValue(e.episode),
                    ))
                .toList(),
            isStrokeCapRound: true,
            isCurved: true,
            barWidth: 4,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.error,
              ],
              stops: const [.4, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            dotData: FlDotData(show: false),
          ),
        ],
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: 50,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Theme.of(context).colorScheme.onBackground,
            dashArray: [5, 10],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      ),
      swapAnimationCurve: Curves.easeInOutCubic,
      swapAnimationDuration: const Duration(milliseconds: 400),
    );
  }

  double _calculateEpisodeSeverityValue(EpisodeSeverity episode) {
    if (episode is Mania) {
      return 50 + episode.level.value * 12.5;
    } else if (episode is Depression) {
      return episode.level.value * 12.5;
    } else {
      return 50;
    }
  }
}
