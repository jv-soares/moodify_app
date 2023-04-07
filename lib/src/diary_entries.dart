import 'dart:math';

import 'models/diary_entry.dart';
import 'models/episode_severity.dart';

final _random = Random();

final diaryEntries = List.generate(
  30,
  (index) => DiaryEntry(
    id: index.toString(),
    createdAt: DateTime(2023, 4, 1).subtract(Duration(days: index)),
    episode: _getEpisode(index),
    moodRating: _random.nextInt(100),
    hoursOfSleep: _random.nextInt(10),
    symptoms: [],
    medications: [],
  ),
);

EpisodeSeverity _getEpisode(int index) {
  final randomInt = _random.nextInt(Level.values.length);
  final level = Level.values[randomInt];
  return index.isEven ? Depression(level) : Mania(level);
}
