import 'package:flutter/material.dart';
import 'package:moodify_app/src/models/diary_entry.dart';
import 'package:moodify_app/src/pages/diary_dashboard/components/episodes_chart_entry.dart';

import '../../models/episode_severity.dart';
import '../../models/life_event.dart';
import '../../models/medication.dart';
import 'components/diary_entry_draggable_bottom_sheet.dart';

class DiaryDashboardPage extends StatelessWidget {
  const DiaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          EpisodesChart(episodes: generateEpisodes()),
          DiaryEntryDraggableBottomSheet(diaryEntry),
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

final diaryEntry = DiaryEntry(
  id: '123',
  createdAt: DateTime.now(),
  episode: Mania(Level.mild),
  moodRating: 50,
  symptoms: [],
  medications: const [
    Medication(
      id: '1',
      name: 'Omeprazol',
      tabletsTaken: 3,
      dose: Dose(300, UnitOfMeasurement.mg),
    ),
    Medication(
      id: '2',
      name: 'Tramadol',
      tabletsTaken: 2,
      dose: Dose(200, UnitOfMeasurement.mg),
    ),
  ],
  lifeEvent: const LifeEvent(
    impactRating: 3,
    description:
        'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
  ),
  observations: 'Foi um dia difícil',
);
