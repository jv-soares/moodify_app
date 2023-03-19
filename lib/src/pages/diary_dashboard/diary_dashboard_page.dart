import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/diary_entry.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart_entry.dart';

import '../../models/episode_severity.dart';
import 'components/diary_entry_draggable_bottom_sheet.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          EpisodesChart(episodes: generateEpisodes()),
          DiaryEntryDraggableBottomSheet(
            DiaryEntry(
              id: 'id',
              createdAt: DateTime.now(),
              episode: Mania(Level.mild),
              moodRating: 50,
              symptoms: [],
              medications: [],
            ),
          ),
        ],
      ),
    );
  }
}

List<EpisodesChartEntry> generateEpisodes() {
  final dates = List.generate(
    episodes.length,
    (index) => DateTime(2022, 1, index + 1),
  );
  return episodes
      .asMap()
      .entries
      .map((e) => EpisodesChartEntry(e.value, dates[e.key]))
      .toList();
}

final episodes = [
  Mania(Level.mild),
  Mania(Level.moderateHigh),
  Balanced(),
  Depression(Level.mild),
  Depression(Level.mild),
  Depression(Level.moderateLow),
  Depression(Level.moderateHigh),
  Balanced(),
  Balanced(),
  Balanced(),
  Mania(Level.mild),
  Mania(Level.moderateHigh),
  Balanced(),
  Depression(Level.mild),
  Depression(Level.mild),
  Depression(Level.moderateLow),
  Depression(Level.moderateHigh),
  Balanced(),
  Balanced(),
  Balanced(),
];
