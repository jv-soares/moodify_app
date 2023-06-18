import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_dashboard/notifiers/diary_dashboard_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/diary_entry.dart';
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
          _buildMoodRatingLine(entries, context),
          _buildSleepLine(entries, context),
          _buildEpisodeSeverityLine(entries, context),
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

  LineChartBarData _buildMoodRatingLine(
    List<DiaryEntry> entries,
    BuildContext context,
  ) {
    return LineChartBarData(
      spots: entries
          .map((e) => FlSpot(_dateToX(e.createdAt), e.moodRating.toDouble()))
          .toList(),
      isStrokeCapRound: true,
      isCurved: true,
      barWidth: 4,
      color: Theme.of(context).colorScheme.tertiaryContainer,
      dotData: FlDotData(show: false),
    );
  }

  LineChartBarData _buildSleepLine(
    List<DiaryEntry> entries,
    BuildContext context,
  ) {
    return LineChartBarData(
      spots: entries
          .map((e) => FlSpot(_dateToX(e.createdAt), e.hoursOfSleep * 10))
          .toList(),
      isStrokeCapRound: true,
      isCurved: true,
      barWidth: 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      dotData: FlDotData(show: false),
    );
  }

  LineChartBarData _buildEpisodeSeverityLine(
    List<DiaryEntry> entries,
    BuildContext context,
  ) {
    return LineChartBarData(
      spots: entries
          .map(
            (e) => FlSpot(_dateToX(e.createdAt), _calculateEpisodeY(e.episode)),
          )
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
    );
  }

  double _dateToX(DateTime date) {
    return DateUtils.dateOnly(date).millisecondsSinceEpoch.toDouble();
  }

  double _calculateEpisodeY(EpisodeSeverity episode) {
    if (episode.isMania) {
      return 50 + episode.levelValue * 12.5;
    } else if (episode.isDepression) {
      return 50 - episode.levelValue * 12.5;
    } else {
      return 50;
    }
  }
}
