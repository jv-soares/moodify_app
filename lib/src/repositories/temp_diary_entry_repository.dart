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
    _entries.add(entry);
    return Random().nextInt(100).toString();
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
