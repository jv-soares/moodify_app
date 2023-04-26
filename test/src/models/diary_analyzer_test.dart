import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/models/diary_analyzer.dart';
import 'package:moodify_app/src/models/diary_entry.dart';
import 'package:moodify_app/src/models/episode_severity.dart';

void main() {
  late DiaryAnalyzer sut;

  setUp(() {
    sut = DiaryAnalyzer(_diaryEntries);
  });

  test('should return average mood', () {
    expect(sut.averageMood, 45);
  });

  test('should return average sleep hours', () {
    expect(sut.averageHoursOfSleep, 4.5);
  });

  test('should return episode distribution', () {
    final distribution = sut.calculateEpisodeDistribution();
    expect(distribution.depression, .5);
    expect(distribution.balanced, .2);
    expect(distribution.mania, .3);
  });
}

final _diaryEntries = List.generate(
  10,
  (index) => DiaryEntry(
    id: index.toString(),
    createdAt: DateTime(2023, 4, 1).subtract(Duration(days: index)),
    episode: _episodes[index],
    moodRating: index * 10,
    hoursOfSleep: index,
    symptoms: const [],
    medications: const [],
  ),
);

final _episodes = [
  Depression(Level.severe),
  Depression(Level.moderateHigh),
  Depression(Level.mild),
  Depression(Level.moderateLow),
  Depression(Level.mild),
  Balanced(),
  Balanced(),
  Mania(Level.moderateLow),
  Mania(Level.mild),
  Mania(Level.moderateHigh),
];
