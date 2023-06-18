import 'dart:math';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

import '../models/diary_entry.dart';
import 'diary_entry_repository.dart';

class TempDiaryEntryRepository implements DiaryEntryRepository {
  TempDiaryEntryRepository() {
    // _controller.add(diaryEntries);
  }

  final _controller = BehaviorSubject<List<DiaryEntry>>();

  @override
  Future<List<DiaryEntry>> readAll() async {
    await _delay;
    if (!_controller.hasValue) return [];
    return _controller.value
        .sortedByCompare((e) => e.createdAt, (a, b) => b.compareTo(a))
        .toList();
  }

  @override
  Future<String> create(DiaryEntry entry) async {
    await _delay;
    if (_controller.hasValue) {
      _controller.add([..._controller.value, entry]);
    } else {
      _controller.add([entry]);
    }
    return Random().nextInt(100).toString();
  }

  Future<void> get _delay => Future.delayed(const Duration(seconds: 1));
}
