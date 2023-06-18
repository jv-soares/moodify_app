import 'dart:math';

import 'package:collection/collection.dart';

import '../models/diary_entry.dart';
import 'diary_entry_repository.dart';

class TempDiaryEntryRepository implements DiaryEntryRepository {
  TempDiaryEntryRepository() {
    // _controller.add(diaryEntries);
  }

  final _entries = <DiaryEntry>[];

  @override
  Future<List<DiaryEntry>> readAll() async {
    await _delay;
    return _entries
        .sortedByCompare((e) => e.createdAt, (a, b) => b.compareTo(a))
        .toList();
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    await _delay;
    final identifiedEntry = DiaryEntry(
      id: Random().nextInt(100).toString(),
      createdAt: entry.createdAt,
      episode: entry.episode,
      moodRating: entry.moodRating,
      hoursOfSleep: entry.hoursOfSleep,
      symptoms: entry.symptoms,
      medications: entry.medications,
      lifeEvent: entry.lifeEvent,
      moodSwitchesPerDay: entry.moodSwitchesPerDay,
      observations: entry.observations,
    );
    _entries.add(identifiedEntry);
    return identifiedEntry.id!;
  }

  @override
  Future<String> update(DiaryEntry entry) async {
    await _delay;
    final index = _entries.indexWhere((e) => e.id == entry.id);
    _entries[index] = entry;
    return entry.id!;
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
