import 'package:collection/collection.dart';
import 'package:moodify_app/src/diary_entries.dart';

import '../core/failures.dart';
import '../models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Future<List<DiaryEntry>> readAll();
  Future<DiaryEntry> read(String id);
  Future<String> create(DiaryEntry entry);
}

class TempDiaryEntryRepository implements DiaryEntryRepository {
  final _entries = <DiaryEntry>{};

  TempDiaryEntryRepository() {
    _entries.addAll(diaryEntries);
  }

  @override
  Future<List<DiaryEntry>> readAll() async {
    await _delay;
    return _entries
        .sortedByCompare((e) => e.createdAt, (a, b) => b.compareTo(a))
        .toList();
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    _entries.add(entry);
    await _delay;
    return entry.id;
  }

  @override
  Future<DiaryEntry> read(String id) async {
    await _delay;
    return _entries.singleWhere(
      (element) => element.id == id,
      orElse: () => throw DiaryEntryNotFoundFailure(),
    );
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
